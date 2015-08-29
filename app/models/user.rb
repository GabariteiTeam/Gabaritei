# == Schema Information
#
# Table name: users
#
#  id         :integer          not null, primary key
#  role_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  first_name :string(255)
#  last_name  :string(255)
#  email      :string(255)
#  password   :string(255)
#  birthdate  :datetime
#  about      :text
#
# Indexes
#
#  index_users_on_role_id  (role_id)
#

class User < ActiveRecord::Base

    # @!attribute first_name
    #   First name of the user.
    #   @return [String] the first name of the user.
    #
    # @!attribute last_name
    #   Last name of the user
    #   @return [String] the last name of the user.
    #  
    # @!attribute email
    #   E-mail of the user
    #   @return [String] the e-mail of the user.
    #
    # @!attribute password
    #   Hashed password of the user
    #   @return [String] the hashed password of the user.
    #  
    # @!attribute birthdate
    #   Bithdate name of the user
    #   @return [String] the birthdate of the user.
    #     
    # @!attribute about
    #   Text about the user.
    #   @return [String] the text about the user.
    #
    # @!attribute avatar
    #   User's avatar
    #   @return [File] the user's avatar.
    has_attached_file :avatar

    # @!group Belongs to
    
    # The role the user has.
    # @return [Role] the role of the user.
    belongs_to :role

    # @!endgroup
    
    # @!group Has many
    
    # All {Content contents} created by the user.
    # @return [Array<Content>] a list of all contents created by the user.
    # @see Content#user
    has_many :contents

    # All {CourseNews news} created by the user.
    # @return [Array<CourseNews>] a list of all news created by the user.
    has_many :course_news

    # All {CourseRegistrationRequest requests} created by the user.
    # @return [Array<CourseRegistrationRequest>] a list of all requests created by the user.  
    has_many :course_registration_requests

    # All {Question questions} created by the user.
    # @return [Array<Question>] a list of all questions created by the user.
    has_many :questions

    # All {Rating ratings} created by the user.
    # @return [Array<Rating>] a list of all ratings created by the user.
    has_many :ratings

    # All {Recommendation recommendations} given by the user.
    # @return [Array<Recommendation>] a list of all recommendations given by the user.
    has_many :sent_recommendations, class_name: "Recommendation", foreign_key: "user_source_id"

    # All {Recommendation news} received by the user.
    # @return [Array<Recommendation>] a list of all recommendations received by the user.
    has_many :received_recommendations, class_name: "Recommendation", foreign_key: "user_destination_id"

    # All {Response responses} created by the user.
    # @return [Array<Response>] a list of all responses created by the user.
    has_many :responses

    # All {Test tests} created by the user.
    # @return [Array<Test>] a list of all tests created by the user.
    has_many :tests

    # All {Course courses} in which the user takes part.
    # @return [Array<Course>] a list of all courses in which the user takes part.
    has_many :courses, through: :user_courses

    # All {Subject subjects} in which the user has difficulties.
    # @return [Array<Subject>] a list of all subjects in which the user has difficulties.
    # @see Subject#users_in_difficulty
    has_many :difficult_subjects, claas_name: "Subject", through: :category_difficulties, source: :category, source_type: "Subject"
    
    # All {Field fields} in which the user has difficulties.
    # @return [Array<Field>] a list of all fields in which the user has difficulties.
    # @see Field#users_in_difficulty
    has_many :difficult_fields, claas_name: "Field", through: :category_difficulties, source: :category, source_type: "Field"
    
    # @!endgroup

    has_many :user_courses
    has_many :category_difficulties
  
    def self.import_user(user_data, user_role)

        # create new user object
        user = User.new

        # set role
        user.role = user_role

        # set fields
        user.email = user_data[:email]
        user.first_name = user_data[:first_name]
        user.last_name = user_data[:last_name]
        if user_data[:birthdate].is_a?(Date)
            user.birthdate = user_data[:birthdate]
        elsif user_data[:birthdate].is_a?(String)
            user.birthdate = DateTime.parse(user_data[:birthdate])
        end
    
        # save new user
        user.save!
    
    end

end
