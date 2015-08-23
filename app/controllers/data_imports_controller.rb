class DataImportsController < ApplicationController
  
	# GET /data_import.json
    def index
		@data_imports = DataImport.includes(:role).all
		render json: @data_imports, :methods => [:data_url, :status_text, :role_name, :update_date_text]
	end

	# File upload
	def create
		@data_import = DataImport.new(data_import_params)
		if @data_import.save
	      render json: {success: true}
	    else
	      render json: @data_import.errors, status: :unprocessable_entity
	    end  
	end

	# Data import
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
	    	params.permit(:id, :data, :model, :role_id, :col_sep)
	    end 

end