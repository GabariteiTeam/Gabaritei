class Role < ActiveRecord::Base
  
	# Referenced by
	has_many :role_permissions
	has_many :user_roles
  
end
