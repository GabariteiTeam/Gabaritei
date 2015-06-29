class Test < ActiveRecord::Base
  
	# References
 	belongs_to :course
 	belongs_to :user

 	# Referenced by
  	has_many :test_questions
  	has_many :questions, through: :test_questions
  	has_many :test_responses
  	has_many :responses, through: :test_responses

end
