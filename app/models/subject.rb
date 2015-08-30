# A subject describe the nature of several entities, like {Course courses}, {Content contents},
# {Question questions} and {Test tests}. A subject can be divided in several {Field fields}.
# {User Users} can also declare they have difficulties in a subject.
#
# == Schema Information
#
# Table name: subjects
#
#  id          :integer          not null, primary key
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  name        :string(255)
#  description :text
#

class Subject < ActiveRecord::Base

	# @!attribute name
	# 	Name of the subject.
	# 	@return [String] the name of the subject.
	#  
	# @!attribute description  
	# 	Description of the subject.
	# 	@return [String] the description of the subject.

	# @!group Has many
	
	# All {Field fields} that belong to the subject.
	# @return [Array<Field>] a list of all fields that belong to the subject.
	has_many :fields

	# All {Test tests} that belong to the subject.
	# @return [Array<Test>] a list of all tests that belong to the subject.	
	has_many :tests, through: :courses

	# All {Course courses} that belong to the subject.
	# @note This method cannot be used to modify the courses associated to the subject.
	#  The direct and indirect methods should be used instead.
	# @return [Array<Course>] a list of all courses that belong to the subject.	
	def courses
  		direct_courses + indirect_courses
  	end

	# All {Content contents} that belong to the subject.
	# @note This method cannot be used to modify the contents associated to the subject.
	#  The direct and indirect methods should be used instead.
	# @return [Array<Content>] a list of all courses that belong to the subject.	
  	def contents
  		direct_contents + indirect_contents
  	end

	# All {Question questions} that belong to the subject.
	# @note This method cannot be used to modify the questions associated to the subject.
	#  The direct and indirect methods should be used instead.
	# @return [Array<Question>] a list of all questions that belong to the subject.	
  	def questions
  		(direct_questions + indirect_questions).uniq
  	end

	# All {User users} who have difficulty in the subject.
	# @note This method cannot be used to modify the users with difficulty in the subject.
	#  The direct and indirect methods should be used instead.
	# @return [Array<User>] a list of all users who have difficulty in the subject.	
  	def users_in_difficulty
  		(direct_users_in_difficulty + indirect_users_in_difficulty).uniq
  	end

	# @!endgroup

	# @!group Has many – Direct associations

	# All {Course courses} that directly belong to the subject.
	# @return [Array<Course>] a list of all courses that directly belong to the subject.
	has_many :direct_courses, class_name: "Course", as: :category

	# All {Content contents} that directly belong to the subject.
	# @return [Array<Content>] a list of all contents that directly belong to the subject.
	has_many :direct_contents, class_name: "Content", as: :category

	# All {Question questions} that directly belong to the subject.
	# @return [Array<Question>] a list of all questions that directly belong to the subject.
	has_many :direct_questions, through: :direct_question_categories, source: :question

	# All {User users} who have difficulty in the subject as a whole (not in specific {Field fields}).
	# @return [Array<User>] a list of all users who have difficulty in the subject as a whole.	
	has_many :direct_users_in_difficulty, through: :direct_category_difficulties, source: :user

	# @!endgroup

	# @!group Has many – Indirect associations

	# All {Course courses} that belong indirectly to the subject (through {Subject#fields fields}).
	# @return [Array<Course>] a list of all courses that indirectly belong to the subject.
	has_many :indirect_courses, class_name: "Course", through: :fields, source: :courses

	# All {Content contents} that belong indirectly to the subject (through {Subject#fields fields}).
	# @return [Array<Content>] a list of all contents that indirectly belong to the subject.
	has_many :indirect_contents, class_name: "Content", through: :fields, source: :contents

	# All {Question questions} that belong indirectly to the subject (through {Subject#fields fields}).
	# @return [Array<Question>] a list of all questions that indirectly belong to the subject.
	has_many :indirect_questions, class_name: "Question", through: :indirect_question_categories, source: :question

	# All {User users} who have difficulty in the subject because they have difficulty in at least one {Field field} that belongs to the subject.
	# @return [Array<User>] a list of all users who have difficulty in the subject through a field of the subject.
	has_many :indirect_users_in_difficulty, class_name:"User", through: :indirect_category_difficulties, source: :user

	# @!endgroup

	has_many :direct_question_categories, class_name: "QuestionCategory", as: :category
	has_many :indirect_question_categories, class_name: "QuestionCategory", through: :fields, source: :question_categories	
	has_many :direct_category_difficulties, class_name: "CategoryDifficulty", as: :category
	has_many :indirect_category_difficulties, class_name: "CategoryDifficulty", through: :fields, source: :category_difficulties


end
