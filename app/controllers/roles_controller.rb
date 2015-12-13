class RolesController < ApplicationController

	def index
		@roles = Role.all
		render json: @roles
  	end

  	def show
		role = Role.includes(:permissions).find(params[:id])
		render json: role, methods: [:permissions]
  	end

  	def new
		@role = Role.new
  	end

  	def create
		@role = Role.new(role_params)
		if params["permissions"]
		  	@role.permissions = Permission.find(params["permissions"])
		end
		if @role.save
		  	render :json => {}
		else
		  	render :json =>  @role.errors, status: :unprocessable_entity
		end
  	end

  	def update
		set_role
		@role.permissions = []
		if params["permissions"]
		  	@role.permissions = Permission.find(params["permissions"])
		end
		if @role.update(role_params)
		  	render :json => {}
		else
		  	render :json =>  @role.errors, status: :unprocessable_entity
		end
  	end

  	def destroy
		set_role
		if @role.destroy
		  	render :json => {}
		else
		  	render :json =>  @role.errors, status: :unprocessable_entity
		end
  	end

  	def validate_destroy
		set_role
		user_count = @role.users.count
		if user_count > 0
		  	render :json => { single: false, count: user_count}
		else
		  	render :json => { single: true }
		end
  	end

  	def roles_for_courses
  		roles = Role.course_roles
  		render json: roles
  	end

private

	def set_role
	  	@role = Role.find(params[:id])
	end

	def role_params
	  	params.require(:role).permit(:id, :name, :description)
	end

end
