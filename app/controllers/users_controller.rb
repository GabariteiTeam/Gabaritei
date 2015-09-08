class UsersController < ApplicationController 

	include CleanPagination

	def index
		max_per_page = 10
		paginate User.count, max_per_page do |limit, offset|
      		render json: User.limit(limit).offset(offset), methods: [:avatar_url_thumb]
    	end
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

	def destroy
		set_user
	    if @user.destroy
	      render :json => {}
	    else
	      render :json =>  @user.errors, status: :unprocessable_entity
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