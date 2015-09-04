# This is an auxiliary model of a join table between {Test} and {Response}. It establishes the "one-to-many" relationship between these models.
# @see Test#responses
# @see Response#test
#
# == Schema Information
#
# Table name: test_responses
#
#  test_id     :integer
#  response_id :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  score       :decimal(4, 2)
#  comment     :text
#
# Indexes
#
#  index_test_responses_on_response_id  (response_id)
#  index_test_responses_on_test_id      (test_id)
#

class TestResponse < ActiveRecord::Base

	# @!attribute score
	# 	The score obtained with the response in the test.
	# 	@return [Float] the score obtained with the response of the question in the test.

	# @!attribute comment 
	# 	Comment over the {TestResponse#score score}.
	# 	@return [String] the comment over the score obtained.
	
	belongs_to :response 
	belongs_to :test
	
end
