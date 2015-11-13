# Data imports are objects that allow data to be parsed and extracted from files. Each data import has a unique file,
# and they import a specific type of data. When importing {User users}, data imports must be associated with a {Role role},
# which indicates the {Role role} of the {User users} who are being imported.
#
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
#  data_file_name    :string(255)
#  data_content_type :string(255)
#  data_file_size    :integer
#  data_updated_at   :datetime
#
# Indexes
#
#  index_data_imports_on_role_id  (role_id)
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

	# @!group Import

	# Imports the data of the data import if it has not been imported yet.
	# @return [void]
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

  	private
	# Parses the dataset looking for users and saving them.
	# @return [void]
  	def import_users
		read_header = false
		last_id = User.last.id
		ActiveRecord::Base.transaction do
			@dataset.each(first_name: 'first_name', last_name: 'last_name', email: 'email', birthdate: 'birthdate') do |hash|
				if read_header
					User.import_user(hash, role)
				else
					read_header = true
				end
			end
		end
		User.find_each(start: last_id + 1) do |user|
			generated_password = Devise.friendly_token.first(8)
			user.password = generated_password
			if user.save!
				#UserMailer.password_creation(user, generated_password).deliver
			end
		end
  	end

	# Parses the dataset looking for subjects and fields and saving them.
	# @return [void]
  	def import_subjects_and_fields
		read_header = false
		subject = nil
		ActiveRecord::Base.transaction do
			@dataset.each do |row|
				if read_header
					if subject == nil || (row[0] != nil && row[0] != subject.name)
						subject = Subject.new({name: row[0], description: row[1]})
						subject.save!
					end
					if row[2]
						Field.new({name: row[2], description: row[3], subject: subject}).save
					end
				else
					read_header = true
				end
			end
		end
  	end

	# Parses the dataset looking for courses and saving them.
	# @return [void]
  	def import_courses
  		ActiveRecord::Base.transaction do
	  		(@dataset.first_column..@dataset.last_column).each do |column_index|
				column_data = @dataset.column(column_index)
				course = Course.new(name: column_data[0], description: column_data[1])
				subject = Subject.where(name: column_data[2]).first
				if subject
					field = nil
					if column_data[3]
						field = Field.where(name: column_data[3], subject: subject).first
						if !field
							raise "Error! Field '" + column_data[3] + "' was not found!"
						end
					end
					course.category = field ? field : subject
					(4..column_data.length).each do |row_index|
						if column_data[row_index]
							user = User.where(email: column_data[row_index])
							if !user.empty?
								course.users.push(user)
							else
								raise "Error! User with e-mail '" + column_data[row_index] + "' was not found!"
							end
						end
					end
					course.save
				else
					raise "Error! Subject '" + column_data[2] + "' was not found!"
				end
			end
		end
  	end

	# Loads the dataset from the file according to its content-type.
	# @return [void]
  	def load_dataset
  		file_name = "public" + data.url.split("?")[0]
  		case data_content_type
  		when FCT_CSV
  			@dataset = Roo::CSV.new(file_name, csv_options: {col_sep: ";"})
  		when FCT_XLS
  			@dataset = Roo::Excel.new(file_name)
  		when FCT_XLSX
  			@dataset = Roo::Excelx.new(file_name)
  		when FCT_ODS
  			@dataset = Roo::OpenOffice.new(file_name)
  		end
  	end

  	# @!endgroup

	# @!group Auxiliary data format methods

	public

	# Returns the data file URL.
	# @return [String] the data file URL.
	def data_url
		data.url
	end

	# Returns a description of the {DataImport#status status}.
	# @return [String] the description of the status.
	def status_text
		case status
		when -1 then I18n.t("data_import.index.table.body.status.not_yet_imported")
		when  0 then I18n.t("data_import.index.table.body.status.currently_being_imported")
		when  1 then I18n.t("data_import.index.table.body.status.successfully_imported")
		else         I18n.t("data_import.index.table.body.status.error")
		end
	end

	# Returns a formatted string of the date in which the file has been uploaded.
	# @return [String] the formatted string of the file upload date.
	def update_date_text
		data_updated_at.strftime("%d/%m/%Y %H:%M:%S")
	end

	# @!endgroup

end
