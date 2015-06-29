class QuestionCategory < ActiveRecord::Base

	# References
	belongs_to :category, polymorphic: true
	belongs_to :question 
	
end