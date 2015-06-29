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

class QuestionChoice < ActiveRecord::Base

	# References
	belongs_to :question
	
	# Referenced by
	has_many :response_choices
	
end
