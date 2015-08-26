# == Description
#
#
# == Schema Information
#
# Table name: question_choices
#
#  id          :integer          not null, primary key
#  question_id :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  text        :string(255)
#  correct     :boolean
#
# Indexes
#
#  index_question_choices_on_question_id  (question_id)
#

class QuestionChoice < ActiveRecord::Base

	belongs_to :question
	has_many :response_choices
	
end
