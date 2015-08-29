# == Schema Information
#
# Table name: roles
#
#  id          :integer          not null, primary key
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  name        :string(255)
#  description :text
#
class Role < ActiveRecord::Base
  
	# @!attribute name
	# 	Name of the role.
	# 	@return [String] the name of the role.
	#  
	# @!attribute description  
	# 	Description of the role.
	# 	@return [String] the description of the role.

	# @!group Has many

	# All {Permission permissions} that the role has.
	# @return [Array<Permissions>] a list of all permissions of the role.
	has_many :permissions, through: :role_permissions

	# All {User users} who have the role.
	# @return [Array<Role>] a list of all users who have the role.
	has_many :users

	# @!endgroup

	has_many :role_permissions

end
