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

class Response < ActiveRecord::Base
  
	# References
	belongs_to :question
	belongs_to :user

	# Referenced by
	has_one :test_response
	has_many :response_choices
	
  
end
