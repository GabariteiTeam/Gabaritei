# == Schema Information
#
# Table name: test_questions
#
#  test_id     :integer
#  question_id :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  max_score   :decimal(4, 2)
#
# Indexes
#
#  index_test_questions_on_question_id  (question_id)
#  index_test_questions_on_test_id      (test_id)
#

class TestQuestion < ActiveRecord::Base

	# References
  	belongs_to :question
  	belongs_to :test
  
end
