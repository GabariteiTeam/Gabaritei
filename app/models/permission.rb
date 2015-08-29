# == Schema Information
#
# Table name: permissions
#
#  id         :integer          not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  name       :string(255)
#
#
# == Description
#
#
class Permission < ActiveRecord::Base

	# @!attribute name
	# 	Name of the permission.
	# 	@return [String] the name of the permission.

	# @!group Has many

    # List of all {Role roles} that possess the permission.
    # @return [Array<Role>] all roles that have the permission.
    # @see Role#permissions
	has_many :roles, through: :role_permissions

	# @!endgroup
	has_many :role_permissions

end
