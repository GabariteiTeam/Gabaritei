class DataImportsController < ApplicationController
  
	# GET /data_import
	# GET /data_import.json
    def index
	    @data_imports = DataImport.all
	    render json: @data_imports, :methods => [:data_url, :status_text]
	end

	# File upload
	def create
		@data_import = DataImport.new(data_import_params)
		if @data_import.save
	      render json: {success: true}
	    else
	      render json: @data_import.errors
	    end  
	end

	# Data import
	def update
		Delayed::Job.enqueue(DataImportJob.new(params[:id]))
		render json: {success: true}
	end

	def destroy
		DataImport.find(params[:id]).destroy
		render json: {success: true}
	end

	private 

	    def data_import_params
	    	params.require(:data_import).permit(:id, :data, :model)
	    end 

end