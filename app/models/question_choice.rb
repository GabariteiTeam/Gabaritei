# If a {Question question} is a "multiple choice" question, it has to have question choice objects
# that represent each of the choices. The {Response responses} from {User users} to this kind of {Question question} are also associated to
# the question choices, indicating the choices a {User user} chose when answering a {Question question}.
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

	# @!attribute text
	# 	Text of the question choice.
	# 	@return [String] the text of the question choice.

	# @!attribute correct
	# 	Determines if the question choice is a true or false.
	# 	@return [Boolean] +true+ if the question choice is right, +false+ otherwise.

	# @!group Belongs to
	
	# The question to which the question choice belongs.
	# @return [Question] the question of the question choice.
	# @see Question@question_choices
	belongs_to :question
	
	# @!endgroup

	# @!group Has many

	# All responses associated to the question choice.
	# @return [Array<Response>] a list of all responses associated to the question choice.
	# @see Response#question_choices
	has_many :responses, through: :response_choices

	# @!endgroup

	has_many :response_choices
	
end
