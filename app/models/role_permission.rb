# == Schema Information
#
# Table name: role_permissions
#
#  role_id       :integer
#  permission_id :integer
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

class RolePermission < ActiveRecord::Base

	# References
	belongs_to :permission
	belongs_to :role

end
