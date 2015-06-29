class RolePermission < ActiveRecord::Base

	# References
	belongs_to :permission
	belongs_to :role

end