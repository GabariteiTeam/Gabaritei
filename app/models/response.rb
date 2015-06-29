class Response < ActiveRecord::Base
  
	# References
	belongs_to :question
	belongs_to :user

	# Referenced by
	has_many :response_choices
	has_many :test_responses
  
end
