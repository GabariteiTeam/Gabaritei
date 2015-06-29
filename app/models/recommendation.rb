class Recommendation < ActiveRecord::Base

	# References
	belongs_to :resource, polymorphic: true
	belongs_to :user_destination, class_name: "User"
	belongs_to :user_source, class_name: "User"
	
end