# == Schema Information
#
# Table name: data_imports
#
#  id                :integer          not null, primary key
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  model             :string(255)
#  status            :integer          default(-1)
#  progress          :integer          default(0)
#  data_file_name    :string(255)
#  data_content_type :string(255)
#  data_file_size    :integer
#  data_updated_at   :datetime
#

require "CSV"

class DataImport < ActiveRecord::Base

	has_attached_file :data
	validates_attachment_content_type :data, content_type: ["text/csv"]

	def import
		imported_rows = 0
		total_rows = row_count
		CSV.foreach(file_name, headers: true, col_sep: ";") do |row|
			user_data = row.to_hash
			User.import_user(user_data)
			imported_rows += 1
			self.progress = (100 * imported_rows) / total_rows
			p self.progress
			self.save!
			sleep 1
		end
  	end

	def data_url
		data.url
	end

	def file_name
		"public" + data_url.split("?")[0]
	end

	def row_count
		count = 0
		CSV.foreach(file_name, headers: true, col_sep: ";") { count += 1 }
		return count
	end

	def status_text
		case status
		when -1 then "Not yet imported"
		when  0 then "Currently being imported"
		when  1 then "Successfully imported"
		else         "Error while importing"
		end
	end

	def model_text
		case model
		when 0 then "Admins"
		when 1 then "Students"
		when 2 then "Teachers"
		when 3 then "Subjects"
		when 4 then "Fields"
		when 5 then "Courses"
		else ""
		end
	end

end
