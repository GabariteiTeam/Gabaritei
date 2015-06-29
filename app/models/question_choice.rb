class QuestionChoice < ActiveRecord::Base

	# References
	belongs_to :question
	
	# Referenced by
	has_many :response_choices
	
end