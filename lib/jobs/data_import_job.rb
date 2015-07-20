require 'CSV'

class DataImportJob < Stuct.new(:file_name)

	def perform
		role = file_name.chomp(".csv")
  		CSV.foreach(file_name, headers: true, col_sep: ";") do |row|
	  		user_data = row.to_hash
	  		user_data["roles"] = [role]
	  		User.import_user(user_data)
  		end
	end

end