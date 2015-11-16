# A response is the answer of a {User user} to a {Question question}. If the {Question question} is answered
# in the context of a {Test test}, then the response object is associated to the {Test test} object, so
# that it can be distinguished from an answer to the same {Question question} as an exercise. If the {Question question}
# has a "multiple choice" style, the chosen {QuestionChoice choices} are associated to the response as well. 
#
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
	# @see Question#responses
	belongs_to :question

	# The {User user} who wrote the response.
	# @return [User] the user who wrote the response.
	# User#responses
	belongs_to :owner, class_name: "User"

	# @!endgroup
	
	# @!group Has one
	
	# The test to which the response belongs. This method
	# is only used if the response is produced during a test.
	# @return [Test] the test to which the response belongs.
	# @see Test#responses
	has_one :test, through: :test_response

	# @!endgroup
	
	# @!group Has many
	
	# The question choices that belong to the response. This
	# method is only valid if the {Response#question question} has
	# a multiple choice style.
	# @return [Array<QuestionChoice>] a list of all question choices of the response.
	# @see QuestionChoice#responses
	has_many :question_choices, through: :response_choices

	# @!endgroup

	def owner_name
		owner.first_name + ' ' + owner.last_name
	end

	has_many :response_choices
	has_one :test_response
	
end

