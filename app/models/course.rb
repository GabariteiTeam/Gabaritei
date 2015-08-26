# == Description
#
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

	# @!method category
	# 	The category is the {Subject subject} or {Field field} to which the course belongs.
	# 	@return [Subject, Field] subject or field to which the course belongs.
    belongs_to :category, polymorphic: true  

    # @!endgroup

    # @!group Has many

    # @!method contents
    # 	List of all accessible {Content contents} of the course.
    # 	@return [Array<Content>] all accessible contents of the course.
    # 	@see Content#courses
    has_many :contents, through: :course_contents

    # @!method course_news
    # 	List of all {CourseNews news} related to the course.
    # 	@return [Array<CourseNews>] all course news.
    has_many :course_news
    
    # @!method questions
    # 	List of all accessible {Question questions} of the course.
    # 	@return [Array<Question>] all accessible questions of the course.
    has_many :questions, through: :questions
    
    # @!method course_registration_requests
    # 	List of all {CourseRegistrationRequest registration requests} for the course.
    # 	@return [Array<CourseRegistrationRequest>] all registration requests for the course.
    has_many :course_registration_requests
    
    # @!method tests
    # 	List of all {Test tests}.
    # 	@return [Array<Test>] all tests of the course.
    has_many :tests
    
    # @!method users
    # 	List of all {User users} taking part in the course.
    # 	@return [Array<User>] all users in the course.
    has_many :users, through: :user_courses

    # @!endgroup

    has_many :user_courses
    has_many :course_questions
    has_many :course_contents

end
