class UsersController < ApplicationController 

	include CleanPagination

	def index
		if current_user.confirm_permissions(["permission.manipulate_users"])
			max_per_page = 10
			paginate User.count, max_per_page do |limit, offset|
	      		render json: User.limit(limit).offset(offset), methods: [:avatar_url_thumb, :active]
	    	end
	    else
	    	render json: {error: "Unauthorized access"}, status: 401
	    end
	end

	def show
		@user = User.find(params[:id])
		render json: @user, methods: [:has_avatar, :avatar, :avatar_url_medium, :role]
	end

	def create
		if current_user.confirm_permissions(["permission.manipulate_users"])
			@user = User.new(user_params)
			generated_password = Devise.friendly_token.first(8)
			@user.password = generated_password
			if @user.save!
				mail = UserMailer.password_creation(@user, generated_password)
				Delayed::Job.enqueue(MailingJob.new(mail))
		    	render json: {success: true}
		    else
		      render json: @user.errors, status: :unprocessable_entity
		    end
		else
	    	render json: {error: "Unauthorized access"}, status: 401
	    end
	end

	def update
		@user = User.find(params[:id])
		if @user.id == current_user.id || current_user.confirm_permissions(["permission.manipulate_users"])
			if user_params[:avatar] == "null"
				@user.avatar = nil
				params.delete :avatar
			end
			if @user.update(user_params)
		      render json: {success: true}
		    else
		      render json: @user.errors, status: :unprocessable_entity
		    end
		else
			render json: {error: "Unauthorized access"}, status: 401
		end
	end

	def destroy
		if current_user.confirm_permissions(["permission.manipulate_users"])
			@user = User.find(params[:id])
		    if @user.destroy
		      render :json => {}
		    else
		      render :json =>  @user.errors, status: :unprocessable_entity
		    end
		else
			render json: {error: "Unauthorized access"}, status: 401
		end
	end

	def verify_permissions
		@user = User.find(params[:id])
		verified = @user.verify_permissions(params[:permissions])
		render json: verified
	end

	private

		def user_params
			params.permit(:id, :first_name, :last_name, :email, :birthdate, :avatar, :about, :role_id)
		end

end