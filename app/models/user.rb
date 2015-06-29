class User < ActiveRecord::Base

    # References
    belongs_to :media

    # Referenced by
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
    has_many :teacher_roles, -> { where(role: "teacher") }, class_name: "UserCourseRole"
    has_many :student_roles, -> { where(role: "student") }, class_name: "UserCourseRole"
    has_many :teacher_courses, through: :teacher_roles, source: :course
    has_many :student_courses, through: :student_roles, source: :course
  
end
