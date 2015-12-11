# A test is an aggregation of {Question questions}. It can be evaluated
# and provide results to its participants in a {Course course}.
#
# == Schema Information
#
# Table name: tests
#
#  id          :integer          not null, primary key
#  course_id   :integer
#  owner_id    :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  name        :string(255)
#  description :text
#
# Indexes
#
#  index_tests_on_course_id  (course_id)
#  index_tests_on_owner_id   (owner_id)
#

class Test < ActiveRecord::Base

	# @!attribute name
	# 	Name of the subject.
	# 	@return [String] the name of the subject.
	#  
	# @!attribute description  
	# 	Description of the subject.
	# 	@return [String] the description of the subject.

	# @!group Belongs to

	# The {Course course} to which the test belongs.
	# @return [Course] the course to which the test belongs.
	# @see Course#tests
	belongs_to :course

	# The owner is the {User user} who created the test.
	# @return [User] user who created the test.
	# @see User#tests
 	belongs_to :owner, class_name: "User"

 	# @!endgroup

	# @!group Has many

    # List of all {Question questions} of the test.
    # @return [Array<Question>] all questions of the test.
    # @see Question#tests
  	has_many :questions, through: :test_questions

  	# List of all {Response responses} of the test's questions.
    # @return [Array<Response>] all responses of the test's question.
    # @see Response#test
  	has_many :responses, through: :test_responses

  	# @!endgroup

  	has_many :test_questions
	has_many :test_responses

	def available_questions
		test_course = course
        if test_course != nil
            if test_course.category.is_a?(Field)
                return test_course.category.subject.questions
            else
                return test_course.category.questions
            end
        end
	end

end
