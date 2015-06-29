class UserDeficitCategory < ActiveRecord::Base

	# References
	belongs_to :category, polymorphic: true
	belongs_to :user

end