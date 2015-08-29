# == Schema Information
#
# Table name: responses
#
#  id          :integer          not null, primary key
#  question_id :integer
#  owner_id    :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  text        :text
#
# Indexes
#
#  index_responses_on_owner_id     (owner_id)
#  index_responses_on_question_id  (question_id)
#
class Response < ActiveRecord::Base

	# @!attribute text
	# 	The text of the response.
	# 	@return [String] the response text.	
  
	# @!group Belongs to
	
	# {Question} to which the response refers.
	# @return [Question] the question to which the response refers.
	belongs_to :question

	# The {User user} who wrote the response.
	# @return [User] the user who wrote the response.
	belongs_to :owner, class_name: "User"

	# @!endgroup
	
	# @!group Has one
	
	# The test to which the response belongs. This method
	# is only used if the response is produced during a test.
	# @return [Test] the test to which the response belongs.
	has_one :test, through: :test_response

	# @!endgroup
	
	# @!group Has many
	
	# The question choices that belong to the response. This
	# method is only valid if the {Response#question question} has
	# a multiple choice style.
	# @return [Array<QuestionChoice>] a list of all question choices of the response.
	has_many :question_choices

	# @!endgroup

	has_many :response_choices
	has_one :test_response
	
end

