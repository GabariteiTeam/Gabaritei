# == Schema Information
#
# Table name: data_imports
#
#  id                :integer          not null, primary key
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  model             :integer
#  status            :integer          default(-1)
#  progress          :integer          default(0)
#  col_sep           :string(255)
#  data_file_name    :string(255)
#  data_content_type :string(255)
#  data_file_size    :integer
#  data_updated_at   :datetime
#

class DataImport < ActiveRecord::Base

	FILE_CONTENT_TYPE = [
		FCT_CSV = "text/csv",
		FCT_XLS = "application/vnd.ms-excel",
		FCT_XLSX = "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet",
		FCT_ODS = "application/vnd.oasis.opendocument.spreadsheet"
	]

	has_attached_file :data
	validates_attachment_content_type :data, 
		content_type: [DataImport::FCT_CSV, 
					   DataImport::FCT_XLS, 
					   DataImport::FCT_XLSX, 
					   DataImport::FCT_ODS]

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
			load_dataset
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
		read_header = false
		@dataset.each(first_name: 'first_name', last_name: 'last_name', email: 'email', birthdate: 'birthdate') do |hash|
			if read_header
				User.import_user(hash, model_role)
				imported_rows += 1
				update_progress(imported_rows, total_rows)
			else
				read_header = true
			end
		end
  	end

  	def load_dataset
  		case data_content_type
  		when FCT_CSV
  			@dataset = Roo::CSV.new(file_name, csv_options: {col_sep: col_sep})
  		when FCT_XLS
  			@dataset = Roo::Excel.new(file_name)
  		when FCT_XLSX
  			@dataset = Roo::Excelx.new(file_name)
  		when FCT_ODS
  			@dataset = Roo::OpenOffice.new(file_name)
  		end
  	end

	def data_url
		data.url
	end

	def file_name
		"public" + data_url.split("?")[0]
	end

	def row_count
		@dataset.last_row
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
		model && model < @@models.length ? @@models[model] : ""
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
