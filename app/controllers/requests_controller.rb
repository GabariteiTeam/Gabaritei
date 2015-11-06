class RequestsController < ApplicationController

	def registration_requests
		if current_user.confirm_permissions(["permission.manage_registration_requests"])
			@requests = RegistrationRequest.all
			render json: @requests, methods: [:requirer, :status]
		else
			render json: {error: "Unauthorized access"}, status: 401
		end
	end

	def course_registration_requests
		if current_user.confirm_permissions(["permission.manage_course_registration_requests"])
			@requests = CourseRegistrationRequest.all
			render json: @requests, methods: [:requirer, :course, :status]
		else
			render json: {error: "Unauthorized access"}, status: 401
		end
	end

	def create_registration_request
		@request = RegistrationRequest.new(registration_request_params)
		if @request.save!
	    	render json: {success: true}
	    else
	      	render json: @request.errors, status: :unprocessable_entity
	    end
	end

	def create_course_registration_request
		@request = CourseRegistrationRequest.new
		@request.requirer = User.find(params[:requirer][:id])
		@request.course = Course.find(params[:course][:id])
		@request.text = params[:text]
		if @request.save!
	    	render json: {success: true}
	    else
	      	render json: @request.errors, status: :unprocessable_entity
	    end
	end

	def get_registration_request
		@request = RegistrationRequest.find(params[:id])
		render json: @request, methods: [:status]
	end

	def get_course_registration_request
		@request = CourseRegistrationRequest.find(params[:id])
		render json: @request, methods: [:requirer, :course, :status]
	end

	def assess_registration_request
		if assessment_params.has_key?(:accepted)
			@request = RegistrationRequest.find(assessment_params[:id])
			params[:request][:response_date] = Time.now
			if assessment_params[:accepted]
				if register_user && @request.update(assessment_params)
					mail = RequestMailer.registration_request_accepted(@request, @generated_password)
					Delayed::Job.enqueue(MailingJob.new(mail))
					render json: {success: true}
				else
					render json: {error: "Error"}, status: :unprocessable_entity
				end
			else
				if @request.update(assessment_params)
					mail = RequestMailer.registration_request_rejected(@request)
					Delayed::Job.enqueue(MailingJob.new(mail))
					render json: {success: true}
				else
					render json: @request.errors, status: :unprocessable_entity
				end
			end
		else
			render json: {error: 'Request without response'}, status: :unprocessable_entity
		end
	end

	def assess_course_registration_request
		if assessment_params.has_key?(:accepted)
			@request = CourseRegistrationRequest.find(assessment_params[:id])
			params[:request][:response_date] = Time.now
			if assessment_params[:accepted]
				if register_user_in_course && @request.update(assessment_params)
					mail = RequestMailer.course_registration_request_accepted(@request)
					Delayed::Job.enqueue(MailingJob.new(mail))
					render json: {success: true}
				else
					render json: {error: "Error"}, status: :unprocessable_entity
				end
			else
				if @request.update(assessment_params)
					mail = RequestMailer.course_registration_request_rejected(@request)
					Delayed::Job.enqueue(MailingJob.new(mail))
					render json: {success: true}
				else
					render json: @request.errors, status: :unprocessable_entity
				end
			end
		else
			render json: {error: 'Request without response'}, status: :unprocessable_entity
		end
	end

	def delete_registration_request
		@request = RegistrationRequest.find(params[:id])
		if @request.destroy
			render json: {success: true}
		else
			render json: @request.errors, status: :unprocessable_entity
		end
	end

	def delete_course_registration_request
		@request = CourseRegistrationRequest.find(params[:id])
		if @request.destroy
			render json: {success: true}
		else
			render json: @request.errors, status: :unprocessable_entity
		end
	end

	private

		def registration_request_params
			params.require(:request).permit(:id, :first_name, :last_name, :email, :birthdate, :text)
		end

		def assessment_params
			params.require(:request).permit(:id, :text, :response, :response_date, :accepted)
		end

		def register_user
			@user = User.new
			@user.role = Role.where(name: 'Student').first
			@user.first_name = registration_request_params[:first_name]
			@user.last_name = registration_request_params[:last_name]
			@user.email = registration_request_params[:email]
			@user.birthdate = registration_request_params[:birthdate]
			@generated_password = Devise.friendly_token.first(8)
			@user.password = @generated_password
			return @user.save!
		end

		def register_user_in_course
			uc = UserCourse.new
			uc.user_id = params[:request][:requirer][:id]
			uc.course_id = params[:request][:course][:id]
			return uc.save!
		end

end