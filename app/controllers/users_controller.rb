class UsersController < ApplicationController 

	include CleanPagination

	skip_before_action :verify_authentication, only: [:reset_password]

	def index
		if current_user.confirm_permissions(["permission.users.manipulate"])
			max_per_page = 10
			paginate User.count, max_per_page do |limit, offset|
	      		render json: User.limit(limit).offset(offset), methods: [:avatar_url_thumb]
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
		if current_user.confirm_permissions(["permission.users.manipulate"])
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
		if @user.id == current_user.id || current_user.confirm_permissions(["permission.users.manipulate"])
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
		if current_user.confirm_permissions(["permission.users.manipulate"])
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

	def change_password
		@user = User.find(current_user.id)
		if @user.update_with_password(password_params)
			sign_in @user, bypass: true
			render json: {success: true}
		else
			render json: @user.errors, status: :unprocessable_entity
		end
	end

	def settings
		user = User.find(params[:id])
		render json: user.setting, methods: [:preferred_language_key]
	end

	def save_settings
		if params[:user_id] == current_user.id
			user_setting = User.find(params[:user_id]).setting
			user_setting.preferred_language = Setting.getLanguageIndex(params[:settings][:preferred_language])
			if user_setting.save!
				render json: {success: true}
			else
				render json: @user.errors, status: :unprocessable_entity
			end			
		else
			render json: {error: "Unauthorized access"}, status: 401
		end
	end

	def reset_password
		user = User.where(email: params[:email])
		if user.length > 0
			user = user[0]
			password = user.reset_password
			if password
				mail = UserMailer.forgot_password(user, password)
				Delayed::Job.enqueue(MailingJob.new(mail))
				render json: {success: true}
			else
				render json: {error: "Error in generating new password!"}, status: 500
			end
		else
			render json: {error: "E-mail not valid!"}, status: :unprocessable_entity
		end
	end

	private

		def user_params
			params.permit(:id, :first_name, :last_name, :email, :birthdate, :avatar, :about, :role_id)
		end

		def password_params
			params.permit(:current_password, :password, :password_confirmation)
		end

end