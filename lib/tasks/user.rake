require 'CSV'

namespace :user do

  desc "Imports users' data from a given CSV file"

  # The import file must be a CSV with a semi-colon (";") separator
  # The name of the file must be the exact name of the role of the users being imported
  task :import, [:filename] => :environment do |task, args|
  	
  end

end
