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

	
	belongs_to :response 
	belongs_to :test
	
end
