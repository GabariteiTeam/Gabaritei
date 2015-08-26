# == Description
#
#
# == Schema Information
#
# Table name: permissions
#
#  id         :integer          not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  name       :string(255)
#

class Permission < ActiveRecord::Base

	has_many :role_permissions
	has_many :roles, through: :role_permissions

end
