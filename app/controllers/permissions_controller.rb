class PermissionsController < ApplicationController

	before_action :verify_permissions

	def index
		@permissions = Permission.all
    	render json: @permissions, methods: [:tag]
	end

	def verify_permissions
		@permissions = current_user.verify_permissions(['permission.roles.manipulate'])
		if !@permissions['permission.roles.manipulate']
			render json: {error: "Unauthorized access"}, status: 401
		end
	end

end