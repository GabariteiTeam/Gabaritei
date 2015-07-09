# == Schema Information
#
# Table name: user_roles
#
#  user_id    :integer
#  role_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class UserRole < ActiveRecord::Base

	# References
	belongs_to :role
	belongs_to :user
	
end
