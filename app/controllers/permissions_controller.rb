class PermissionsController < ApplicationController

	def index
		@permissions = Permission.all
    	render json: @permissions, methods: [:tag]
	end

end