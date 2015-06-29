class TestQuestion < ActiveRecord::Base

	# References
  	belongs_to :question
  	belongs_to :test
  
end
