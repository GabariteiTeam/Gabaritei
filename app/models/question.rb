# == Schema Information
#
# Table name: questions
#
#  id         :integer          not null, primary key
#  owner_id   :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  text       :text
#  answer     :text
#  hot        :boolean
#  source     :string(255)
#  date       :datetime
#  style      :string(255)
#
# Indexes
#
#  index_questions_on_owner_id  (owner_id)
#
class Question < ActiveRecord::Base

	# These are the available questions styles.
	STYLES = [
		STYLE_WRITTEN = 'written', 
		STYLE_CHOICE = 'choice'
	]

	# @!attribute text
	# 	Text of the question.
	# 	@return [String] the text of the question.

	# @!attribute answer
	# 	Official answer of the question. To be used in corrections.
	# 	@return [String] the answer of the question.	

	# @!attribute hot
	# 	Determines if a question is "hot" or not.
	# 	@return [Boolean] +true+ if the question is "hot", +false+ otherwise.

	# @!attribute source
	# 	The source of the question (if it is not created by the owner).
	# 	@return [String] the source of the question.

	# @!attribute date
	# 	Date of the question creation. If the question is extracted from a {Question#source source},
	# 	this attribute should keep the date of publication.
	# 	@return [DateTime] the date of the question.

	# @!attribute style
	# 	The style of the question.
	# 	@return [String] the style of the question.

	# @!group Belongs to
	
	# The owner is the {User user} who created the question.
	# @return [User] user who created the question.
	belongs_to :owner, class_name: "User"
	
	# @!endgroup

	# @!group Has many

	# All {Course courses} that have access to the question.
	# @return [Array<Course>] a list of all courses that have access to the question.
	has_many :courses, through: :course_questions
	
	# All {Subject subjects} to which the question belongs.
	# @return [Array<Subject>] a list of all subjects to which the question belongs.
	# @see Subject#questions
	has_many :subjects, through: :question_categories, source: :category, source_type: "Subject"
	
	# All {Field fields} to which the question belongs.
	# @return [Array<Field>] a list of all fields to which the question belongs.
	# @see Field#questions
	has_many :fields, through: :question_categories, source: :category, source_type: "Field"
	
	# All {QuestionChoice choices} of the question in case of a multiple choice question.
	# @return [Array<QuestionChoice>] a list containing all the question choices.
	has_many :question_choices

	# All {Media media} objects possessed by the question.
	# @return [Array<Media>] a list of all media objects of the question.
	has_many :medias, as: :owner

	# All {Rating ratings} of the question.
	# @return [Array<Rating>] a list of all ratings of the question.
	has_many :ratings

	# All {Recommendation recommendations} of the question.
	# @return [Array<Recommendation>] a list of all recommendations of the question.
	has_many :recommendations, as: :resource

	# All {Response responses} to the question.
	# @return [Array<Response>] a list of all responses to the question.
	has_many :responses											
	
	# All {Test tests} containing the question.
	# @return [Array<Test>] a list of all tests containing the question.
	has_many :tests, through: :test_questions

	# All {Subject subjects} and {Field fields} to which the question belongs.
	# @return [Array<Subject, Field>] a list of all subjects and fields to which the question belongs.
	def categories
		subjects + fields
	end

	# @!endgroup

	has_many :course_questions
	has_many :question_categories
	has_many :test_questions
	
end
