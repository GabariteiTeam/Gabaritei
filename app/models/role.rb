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
  
	# Referenced by
	has_many :role_permissions
	has_many :user_roles

	def self.admin_role
		where(name: "Admin").first
	end

	def self.teacher_role
		where(name: "Teacher").first
	end

	def self.student_role
		where(name: "Student").first
	end
  
end
