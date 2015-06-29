class QuestionMedia < ActiveRecord::Base

	# References
	belongs_to :media
	belongs_to :question

end