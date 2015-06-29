class Rating < ActiveRecord::Base
  
	# References
	belongs_to :question
	belongs_to :user
	
end
