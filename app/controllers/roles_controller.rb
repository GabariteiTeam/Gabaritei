class RolesController < ApplicationController

	before_action :verify_permissions, except: [:index, :roles_for_courses]

	def index
		@roles = Role.all
		render json: @roles
  	end

  	def show
		role = Role.includes(:permissions).find(params[:id])
		render json: role, methods: [:permissions]
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

	def verify_permissions
		@permissions = current_user.verify_permissions(['permission.roles.manipulate'])
		if !@permissions['permission.roles.manipulate']
			render json: {error: "Unauthorized access"}, status: 401
		end
	end

end
