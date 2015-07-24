# == Schema Information
#
# Table name: users
#
#  id         :integer          not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  first_name :string(255)
#  last_name  :string(255)
#  email      :string(255)
#  password   :string(255)
#  birthdate  :datetime
#  about      :text
#

class User < ActiveRecord::Base

    # Referenced by
    has_one :profile_picture, class_name: "Media", as: :owner
    has_many :contents
    has_many :course_news
    has_many :course_registration_requests
    has_many :questions
    has_many :ratings
    has_many :sent_recommendations, class_name: "Recommendation", foreign_key: "user_source_id"
    has_many :received_recommendations, class_name: "Recommendation", foreign_key: "user_destination_id"
    has_many :responses
    has_many :tests
    has_many :user_course_roles
    has_many :user_deficit_categories
    has_many :user_roles
    has_many :roles, through: :user_roles
    has_many :teacher_roles, -> { where(role: "teacher") }, class_name: "UserCourseRole"
    has_many :student_roles, -> { where(role: "student") }, class_name: "UserCourseRole"
    has_many :teacher_courses, through: :teacher_roles, source: :course
    has_many :student_courses, through: :student_roles, source: :course
  
    def self.import_user(user_data, user_role)

        # create new user object
        user = User.new
        
        # set role
        user.roles = [user_role]

        # set fields
        user.email = user_data["email"]
        user.first_name = user_data["first_name"]
        user.last_name = user_data["last_name"]
        user.birthdate = DateTime.parse(user_data["birthdate"])

        # save new user
        user.save!
    
    end

end
