# == Schema Information
#
# Table name: course_questions
#
#  question_id :integer
#  course_id   :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
# Indexes
#
#  index_course_questions_on_course_id    (course_id)
#  index_course_questions_on_question_id  (question_id)
#

class CourseQuestion < ActiveRecord::Base
  
	belongs_to :course
	belongs_to :question
  
end
