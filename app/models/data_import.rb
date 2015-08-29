# == Schema Information
#
# Table name: data_imports
#
#  id                :integer          not null, primary key
#  role_id           :integer
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
# Indexes
#
#  index_data_imports_on_role_id  (role_id)
#

# == Description
#
#
class DataImport < ActiveRecord::Base

	# These are the allowed file formats (content-types) for the data import.
	FILE_CONTENT_TYPE = [
		FCT_CSV = "text/csv", # CSV file
		FCT_XLS = "application/vnd.ms-excel", # MS Excel 97-2004 (XLS)
		FCT_XLSX = "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet", # MS Excel (XLSX)
		FCT_ODS = "application/vnd.oasis.opendocument.spreadsheet" # OpenOffice Spreadsheet (ODS)
	]

	# @!attribute model
	# 	Determines what kind of the imported entities.
	# 	 (model = 0) => Import of Users
	# 	 (model = 1) => Import of Subjects and Fields
	# 	 (model = 2) => Import of Courses
	# 	@return [Integer] the integer value corresponding to the type of the imported entities.
	#  
	# @!attribute status  
	# 	Describes in what state the import of data is.
	# 	 (status = -1) => Not yet imported
	# 	 (status =  0) => Currently being imported
	# 	 (status =  1) => Successfully imported
	# 	 (status >  1) => Error 
	# 	@return [Integer] the integer value corresponding to the status of the import.
	#
	# @!attribute [r] progress
	# 	Percentage of how many entities have been imported.
	# 	@note This attribute should only be set by a background process which executes the data import. It can
	# 		be used to display almost in real time the progress of the import.
	# 	@return [Integer] the progress of the data import in percentage.
	#
	# @!attribute col_sep
	# 	Character or string that is used as separator in case data is contained in a CSV file.
	# 	@return [String] the CSV file separator.
	#
	# @!attribute data
	# 	Uploaded file which contains the imported data.
	# 	@return [File] the file which contains the imported data.
	has_attached_file :data

	# @!group Belongs to

	# If the imported entities are {User users} ({DataImport#model model} = 0), this association indicates
	# the {Role role} of the {User users} being imported. 
	# @return [Role] the role of imported users.
	belongs_to :role
	
	# @!endgroup

	# @!group Validations

	# Validates the presence of the attribute {DataImport#model model}. If the attribute is absent, the object cannot be saved.
	# @return [Boolean] "true" if the attribute is present, "false" otherwise.
	validates :model, presence: true

	# Validates the presence of the file attachment {DataImport#data data}. If the attachment is absent, the object cannot be saved.
	# @return [Boolean] "true" if the attachment is present, "false" otherwise.
	validates_attachment_presence :data

	# Validates the content type of the file attachment {DataImport#data data}. If the file's content type is not among the specified ones, 
	# the object cannot be saved.
	# Allowed content types:
	#  DataImport::FCT_CSV  = "text/csv"
	#  DataImport::FCT_XLS  = "application/vnd.ms-excel"
	#  DataImport::FCT_XLSX = "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet"
	#  DataImport::FCT_ODS  = "application/vnd.oasis.opendocument.spreadsheet"
	# @return [Boolean] "true" if the file has an allowed content type, "false" otherwise.
	validates_attachment_content_type :data, content_type: [DataImport::FCT_CSV, DataImport::FCT_XLS, DataImport::FCT_XLSX, DataImport::FCT_ODS]

	# @!endgroup

	def import
		if status == 0
			load_dataset
			case model
			when 0 then import_users
			when 1 then import_subjects_and_fields
			when 2 then import_courses
			end
		end
  	end

  	def import_users
  		imported_rows = 0
		total_rows = row_count
		read_header = false
		@dataset.each(first_name: 'first_name', last_name: 'last_name', email: 'email', birthdate: 'birthdate') do |hash|
			if read_header
				User.import_user(hash, role)
				imported_rows += 1
				update_progress(imported_rows, total_rows)
			else
				read_header = true
			end
		end
  	end

  	def import_subjects_and_fields
  		imported_rows = 0
		total_rows = row_count
		read_header = false
		subject = nil
		@dataset.each do |row|
			if read_header
				if subject == nil || (row[0] != nil && row[0] != subject.name)
					subject = Subject.new({name: row[0], description: row[1]})
					subject.save!
				end
				if row[2]
					Field.new({name: row[2], description: row[3], subject: subject}).save
				end
				imported_rows += 1
				update_progress(imported_rows, total_rows)
			else
				read_header = true
			end
		end
  	end

  	def import_courses
  		imported_columns = 0
  		total_columns = @dataset.last_column
  		(@dataset.first_column..@dataset.last_column).each do |column_index|
			column_data = @dataset.column(column_index)
			course = Course.new(name: column_data[0], description: column_data[1])
			subject = Subject.where(name: column_data[2]).first
			if subject
				field = column_data[3] ? Field.where(name: column_data[3], subject: subject).first : nil
				course.category = field ? field : subject
				(4..column_data.length).each do |row_index|
					user = User.where(email: column_data[row_index])
					if user
						course.users.push(user)
					end
				end
				course.save
			end
			imported_columns += 1
			update_progress(imported_columns, total_columns)
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

	def role_name
		role != nil ? role.name : nil
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

	def update_date_text
		data_updated_at.strftime("%d/%m/%Y %H:%M:%S")
	end

end
