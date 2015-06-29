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

class TestResponse < ActiveRecord::Base

	# References
	belongs_to :response 
	belongs_to :test
	
end
