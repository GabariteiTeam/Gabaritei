class UserRole < ActiveRecord::Base

	# References
	belongs_to :role
	belongs_to :user
	
end