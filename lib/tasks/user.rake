require 'CSV'

namespace :user do

  desc "Imports users' data from a given CSV file"

  # The import file must be a CSV with a semi-colon (";") separator
  # The name of the file must be the exact name of the role of the users being imported
  task :import, [:filename] => :environment do |task, args|
  	role = args[:filename].chomp(".csv")
  	CSV.foreach(args[:filename], headers: true, col_sep: ";") do |row|
  		user_data = row.to_hash
  		user_data["roles"] = [role]
  		User.import_user(user_data)
  	end
  end

end
