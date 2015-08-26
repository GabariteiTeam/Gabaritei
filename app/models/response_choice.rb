# == Description
#
#
# == Schema Information
#
# Table name: response_choices
#
#  response_id         :integer
#  question_choices_id :integer
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#
# Indexes
#
#  index_response_choices_on_response_id  (response_id)
#

class ResponseChoice < ActiveRecord::Base

	
	belongs_to :question_choice
	belongs_to :response

end
