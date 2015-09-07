class UsersController < ApplicationController

	def index
		users = User.all
		render json: users, methods: [:avatar_url_thumb]
	end

	def show
		set_user
		render json: @user, methods: [:has_avatar, :avatar, :avatar_url_medium, :role]
	end

	def create
		@user = User.new(user_params)
		if param_birthdate
			@user.birthdate = param_birthdate
		end
		if @user.save
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

	def delete
		set_role
	    if @role.destroy
	      render :json => {}
	    else
	      render :json =>  @role.errors, status: :unprocessable_entity
	    end
	end

	private

		def user_params
			params.permit(:id, :first_name, :last_name, :email, :birthdate, :avatar, :about, :role_id)
		end

		def set_user
			@user = User.find(params[:id])
		end

end