class DataImportsController < ApplicationController
  
	before_action :verify_permissions

    def index
		@data_imports = DataImport.includes(:role).all
		render json: @data_imports, :methods => [:data_url, :status_text, :role, :update_date_text]
	end

	def create
		@data_import = DataImport.new(data_import_params)
		if @data_import.save
	      render json: {success: true}
	    else
	      render json: @data_import.errors, status: :unprocessable_entity
	    end  
	end

	def update
		@data_import = DataImport.find(data_import_params[:id])
		if @data_import.update(data_import_params)
	      render json: {success: true}
	    else
	      render json: @data_import.errors, status: :unprocessable_entity
	    end 
	end

	def import
		Delayed::Job.enqueue(DataImportJob.new(params[:id]))
		render json: {success: true}
	end

	def destroy
		DataImport.find(params[:id]).destroy
		render json: {success: true}
	end

	private 

	    def data_import_params
	    	params.permit(:id, :data, :model, :role_id)
	    end

	    def verify_permissions
	    	@permissions = current_user.verify_permissions(['permission.import_data'])
	    	if !@permissions['permission.import_data']
	    		render json: {error: "Unauthorized access"}, status: 401
	    	end
	    end

end