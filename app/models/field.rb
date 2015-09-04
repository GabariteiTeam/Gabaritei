# A field is a sub-division of a {Subject}. {Course Courses}, {Content contents} and {Question questions}
# can be related to a specific field instead of a general {Subject subject}. "Geometry", for example, would be a 
# field of the subject "Math".
#
# == Schema Information
#
# Table name: fields
#
#  id          :integer          not null, primary key
#  subject_id  :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  name        :string(255)
#  description :text
#
# Indexes
#
#  index_fields_on_subject_id  (subject_id)
#

class Field < ActiveRecord::Base

	# @!attribute name
	# 	Name of the field.
	# 	@return [String] the name of the field.
	#  
	# @!attribute description  
	# 	Description of the field.
	# 	@return [String] the description of the field.

	# @!group Belongs to

	# Subject to which the field belongs to.
	# @return [Role] the subject to which the field belongs to.
	# @see Subject#fields
	belongs_to :subject

	# @!endgroup

	# @!group Has many

    # List of all {Content contents} associated to the field.
    # @return [Array<Content>] all contents of the field.
    # @see Content#category
	has_many :contents, as: :category
  
    # List of all {Course courses} associated to the field.
    # @return [Array<Course>] all courses of the field.
    # @see Course#category	
	has_many :courses, as: :category

	# List of all {Question questions} associated to the field.
	# @return [Array<Question>] all questions of the field.
	# @see Question#fields
	has_many :questions, through: :question_categories

	# List of all {User users} who have difficulties in the field.
	# @return [Array<User>] all users with difficulties in the field.
	# @see User#difficult_fields
	has_many :users_in_difficulty, through: :category, source: :user

	# @!endgroup

	has_many :question_categories, as: :category
	has_many :category_difficulties, as: :category

end
