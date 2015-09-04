# A course is an aggregation of {User users} with different {Role roles} (like teachers and students). A course belongs to
# a category ({Subject subject} or {Field field}). {User Users}, according to the {Permission permissions} of their {Role roles}, can create 
# and share {Content contents} in the course, add {CourseNews news}, {Question questions} (as exercises), and {Test tests} to the course. 
# Other {User users} can take {Test tests} and make {Question exercises}. {User Users} who do not belong to a course can request their registration 
# with a {CourseRegistrationRequest course registration request}.
#
# == Schema Information
#
# Table name: courses
#
#  id            :integer          not null, primary key
#  category_id   :integer
#  category_type :string(255)
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  name          :string(255)
#  description   :text
#
# Indexes
#
#  index_courses_on_category_id_and_category_type  (category_id,category_type)
#

class Course < ActiveRecord::Base

	# @!attribute name
	# 	Name of the course.
	# 	@return [String] the name of the course.
	#  
	# @!attribute description  
	# 	Description of the course.
	# 	@return [String] the description of the course.
  
  	# @!group Belongs to

	# The category is the {Subject subject} or {Field field} to which the course belongs.
	# @return [Subject, Field] subject or field to which the course belongs.
	# @see Subject#courses
	# @see Field#courses
    belongs_to :category, polymorphic: true

    # @!endgroup

    # @!group Has many

    # List of all accessible {Content contents} of the course.
    # @return [Array<Content>] all accessible contents of the course.
    # @see Content#courses
    has_many :contents, through: :course_contents

    # List of all {CourseNews news} related to the course.
    # @return [Array<CourseNews>] all course news.
    # @see CourseNews#course
    has_many :course_news
    
    # List of all accessible {Question questions} of the course.
    # @return [Array<Question>] all accessible questions of the course.
    # @see Question#courses
    has_many :questions, through: :questions
    
    # List of all {CourseRegistrationRequest registration requests} for the course.
    # @return [Array<CourseRegistrationRequest>] all registration requests for the course.
    # @see CourseRegistrationRequest#course
    has_many :course_registration_requests
    
    # List of all {Test tests}.
    # @return [Array<Test>] all tests of the course.
    # @see Test#course
    has_many :tests
    
    # List of all {User users} taking part in the course.
    # @return [Array<User>] all users in the course.
    # @see User#courses
    has_many :users, through: :user_courses

    # @!endgroup

    has_many :user_courses
    has_many :course_questions
    has_many :course_contents

end
