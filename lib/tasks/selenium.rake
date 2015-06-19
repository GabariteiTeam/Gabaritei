namespace :selenium do
  desc "TODO"
  task :testintegration  => :environment do
  	# fire-up server
  	system "rails s -e test & exec rake test:integration"

  	# Find PID from rails process
  	puts "Finishing server..."

  	#send shutdown signal
  	system " ps aux  | grep rails | grep -v grep | awk '{print $2}' | xargs -I pid kill -INT pid"
  end

end
