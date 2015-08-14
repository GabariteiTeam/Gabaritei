class DataImportsController < ApplicationController
  
	# GET /data_import.json
    def index
		data_imports = DataImport.all
		render json: data_imports, :methods => [:data_url, :status_text, :model_text]
	end

	# File upload
	def create
		p data_import_params
		@data_import = DataImport.new(data_import_params)
		if @data_import.save
	      render json: {success: true}
	    else
	      render json: @data_import.errors
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

	def models
		render json: DataImport.models
	end

	private 

	    def data_import_params
	    	params.permit(:id, :data, :model, :col_sep)
	    end 

end