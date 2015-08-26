# == Description
#
#
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
  
	
	has_many :role_permissions
	has_many :users
	
end
