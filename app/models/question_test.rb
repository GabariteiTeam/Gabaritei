# == Schema Information
#
# Table name: question_tests
#
#  test_id     :integer
#  question_id :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class QuestionTest < ActiveRecord::Base
  
  belongs_to :question
  belongs_to :test
  
end
