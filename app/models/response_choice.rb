# == Schema Information
#
# Table name: response_choices
#
#  response_id         :integer
#  question_choices_id :integer
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#

class ResponseChoice < ActiveRecord::Base

	# References
	belongs_to :question_choice
	belongs_to :response

end
