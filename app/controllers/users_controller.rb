class UsersController < ApplicationController 

	include CleanPagination

	def index
		max_per_page = 10
		paginate User.count, max_per_page do |limit, offset|
      		render json: User.limit(limit).offset(offset), methods: [:avatar_url_thumb, :active]
    	end
	end

	def show
		set_user
		render json: @user, methods: [:has_avatar, :avatar, :avatar_url_medium, :role]
	end

	def create
		@user = User.new(user_params)
		generated_password = Devise.friendly_token.first(8)
		@user.password = generated_password
		if @user.save!
			UserMailer.password_creation(@user, generated_password).deliver
	    	render json: {success: true}
	    else
	      render json: @user.errors, status: :unprocessable_entity
	    end  
	end

	def update
		set_user
		if !user_params.has_key?(:avatar)
			@user.avatar = nil
		elsif !user_params[:avatar]
			user_params.delete :avatar
		end
		if @user.update(user_params)
	      render json: {success: true}
	    else
	      render json: @user.errors, status: :unprocessable_entity
	    end  
	end

	def destroy
		set_user
	    if @user.destroy
	      render :json => {}
	    else
	      render :json =>  @user.errors, status: :unprocessable_entity
	    end
	end

	def verify_permissions
		set_user
		user_permissions = []
		verified = {}
		user_permissions = @user.permissions.map { |permission| permission.name }
		params[:permissions].each do |permission|
			if user_permissions.include?(permission)
				verified[permission] = true
				user_permissions.delete(permission)
			else
				verified[permission] = false
			end
		end
		render json: verified
	end

	private

		def user_params
			params.permit(:id, :first_name, :last_name, :email, :birthdate, :avatar, :about, :role_id)
		end

		def set_user
			@user = User.find(params[:id])
		end

end