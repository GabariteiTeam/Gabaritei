class Permission < ActiveRecord::Base

	# Referenced by
	has_many :role_permissions
	has_many :roles, through: :role_permissions

end