# == Schema Information
#
# Table name: course_questions
#
#  question_id :integer
#  course_id   :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class CourseQuestion < ActiveRecord::Base
  
	# References
	belongs_to :course
	belongs_to :question
  
end
