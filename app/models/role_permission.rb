# == Schema Information
#
# Table name: role_permissions
#
#  role_id       :integer
#  permission_id :integer
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#
# Indexes
#
#  index_role_permissions_on_permission_id  (permission_id)
#  index_role_permissions_on_role_id        (role_id)
#

class RolePermission < ActiveRecord::Base

	# References
	belongs_to :permission
	belongs_to :role

end
