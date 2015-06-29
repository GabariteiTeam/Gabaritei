class TestResponse < ActiveRecord::Base

	# References
	belongs_to :response 
	belongs_to :test
	
end