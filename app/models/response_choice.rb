# This is an auxiliary model of a join table between {Response} and {QuestionChoice}. It establishes the "many-to-many" relationship between these models.
# @see QuestionChoice#responses
# @see Response#question_choices
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
