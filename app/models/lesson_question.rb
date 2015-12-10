# This is an auxiliary model of a join table between {Course} and {Question}. It establishes the "many-to-many" relationship between these models.
# @see Course#questions
# @see Question#courses
#
# == Schema Information
#
# Table name: lesson_questions
#
#  id          :integer          not null, primary key
#  question_id :integer
#  lesson_id   :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
# Indexes
#
#  index_lesson_questions_on_lesson_id    (lesson_id)
#  index_lesson_questions_on_question_id  (question_id)
#

class LessonQuestion < ActiveRecord::Base
  
	belongs_to :lesson
	belongs_to :question
  
end
