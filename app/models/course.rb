# == Schema Information
#
# Table name: courses
#
#  id         :integer          not null, primary key
#  subject_id :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  name       :string(255)
#

class Course < ActiveRecord::Base
  
  belongs_to :subject
  has_many :teacher_roles, -> { where(role: "teacher") }, class_name: "UserCourseRole"
  has_many :student_roles, -> { where(role: "student") }, class_name: "UserCourseRole"
  
  has_many :teachers, through: :teacher_roles, source: :user
  has_many :students, through: :student_roles, source: :user
  
  has_many :tests
  
  
end
