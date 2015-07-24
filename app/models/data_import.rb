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

	@@models = [
		Role.admin_role.name,
		Role.student_role.name,
		Role.teacher_role.name,
		"Subjects",
		"Fields",
		"Courses"
	]

	def import
		if status == 0
			case model
			when 0..2 then import_users
			when 3    then import_subjects
			when 4    then import_fields
			when 5    then import_courses
			end
		end
  	end

  	def import_users
  		imported_rows = 0
		total_rows = row_count
		CSV.foreach(file_name, headers: true, col_sep: ",") do |row|
			User.import_user(row.to_hash, model_role)
			imported_rows += 1
			update_progress(imported_rows, total_rows)
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

	def update_progress(imported_rows, total_rows)
		self.progress = (100 * imported_rows) / total_rows
		self.save!
	end

	def status_text
		case status
		when -1 then "Not yet imported"
		when  0 then "Currently being imported"
		when  1 then "Successfully imported"
		else         "Error while importing! Please verify the file"
		end
	end

	def self.models
		@@models
	end

	def model_text
		model < @@models.length ? @@models[model] : ""
	end

	def model_role
		case model
		when 0 then Role.admin_role
		when 1 then Role.student_role
		when 2 then Role.teacher_role
		else nil
		end
	end

end
