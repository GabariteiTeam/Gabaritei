# == Description
#
#
# == Schema Information
#
# Table name: user_roles
#
#  user_id    :integer
#  role_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_user_roles_on_role_id  (role_id)
#  index_user_roles_on_user_id  (user_id)
#

class UserRole < ActiveRecord::Base

	
	belongs_to :role
	belongs_to :user
	
end
