# This is an auxiliary model of a join table between {Role} and {Permission}. It establishes the "many-to-many" relationship between these models.
# @see Role#permissions
# @see Permission#roles
#
# == Schema Information
#
# Table name: role_permissions
#
#  id            :integer          not null, primary key
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

	belongs_to :permission
	belongs_to :role

end
