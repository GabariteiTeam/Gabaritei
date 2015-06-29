class ResponseChoice < ActiveRecord::Base

	# References
	belongs_to :question_choice
	belongs_to :response

end