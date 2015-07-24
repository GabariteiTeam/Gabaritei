# Delayed jobs are executed by the rake jobs:work Worker!

class DataImportJob < Struct.new(:data_import_id)

	def enqueue(job)
		data_import = DataImport.find(data_import_id)
		data_import.status = 0
		data_import.save!
	end

	def perform
		data_import = DataImport.find(data_import_id)
		data_import.import
	end

	def success(job)
		data_import = DataImport.find(data_import_id)
		data_import.status = 1
		data_import.save!
	end

	def failure(job)
		data_import = DataImport.find(data_import_id)
		data_import.status = 2
		data_import.save!
	end

	def max_attempts
    	1
  	end

end