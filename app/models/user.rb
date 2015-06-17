# == Schema Information
#
# Table name: users
#
#  id         :integer          not null, primary key
#  role_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  name       :string(255)
#

class User < ActiveRecord::Base
  
  belongs_to :role
  
  has_many :teacher_roles, -> { where(role: "teacher") }, class_name: "UserCourseRole"
  has_many :student_roles, -> { where(role: "student") }, class_name: "UserCourseRole"
  
  has_many :teacher_courses, through: :teacher_roles, source: :course
  has_many :student_courses, through: :student_roles, source: :course
  
  has_many :ratings
  has_many :responses
  has_many :contents
  
  has_many :questions
  
  has_many :tests
  
end
