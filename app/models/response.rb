# == Schema Information
#
# Table name: responses
#
#  id          :integer          not null, primary key
#  question_id :integer
#  user_id     :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  text        :text
#
# Indexes
#
#  index_responses_on_question_id  (question_id)
#  index_responses_on_user_id      (user_id)
#

class Response < ActiveRecord::Base
  
	
	belongs_to :question
	belongs_to :user

	
	has_one :test_response
	has_many :response_choices
	
  
end

