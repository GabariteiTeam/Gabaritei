require "CSV"

class DataImport < ActiveRecord::Base

	has_attached_file :data
	validates_attachment_content_type :data, :content_type => ["text/csv"]

	def import
		file_name = "public" + data_url.split("?")[0]
		CSV.foreach(file_name, headers: true, col_sep: ";") do |row|
			user_data = row.to_hash
			User.import_user(user_data)
		end
  	end

	def data_url
		data.url
	end

	def status_text
		case status
		when -1 then "Not yet imported"
		when 0 then "Currently being imported"
		when 1 then "Successfully imported"
		else "Error while importing"
		end
	end
	
end