# A user is a person who uses the system.
#
# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  role_id                :integer
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  first_name             :string(255)
#  last_name              :string(255)
#  birthdate              :datetime
#  about                  :text
#  avatar_file_name       :string(255)
#  avatar_content_type    :string(255)
#  avatar_file_size       :integer
#  avatar_updated_at      :datetime
#  email                  :string(255)      default(""), not null
#  encrypted_password     :string(255)      default(""), not null
#  reset_password_token   :string(255)
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string(255)
#  last_sign_in_ip        :string(255)
#
# Indexes
#
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#  index_users_on_role_id               (role_id)
#

class User < ActiveRecord::Base

    # Include default devise modules. Others available are:
    # :confirmable, :lockable, :timeoutable and :omniauthable
    devise :database_authenticatable, :recoverable, :rememberable, :trackable, :validatable

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
    # @!attribute encrypted_password
    #   Encrypted password of the user
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
    has_attached_file :avatar, styles: { medium: "300x300>", thumb: "75x75>" }, default_url: "/images/missing_avatar/:style.png"
    validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\Z/

    # @!group Belongs to
    
    # The role the user has.
    # @return [Role] the role of the user.
    # @see Role#users
    belongs_to :role

    # @!endgroup

    has_one :setting
    
    # @!group Has many
    
    # All {Content contents} created by the user.
    # @return [Array<Content>] a list of all contents created by the user.
    # @see Content#owner
    has_many :contents

    # All {CourseNews news} created by the user.
    # @return [Array<CourseNews>] a list of all news created by the user.
    # @see CourseNews#owner
    has_many :course_news

    # All {CourseRegistrationRequest requests} created by the user.
    # @return [Array<CourseRegistrationRequest>] a list of all requests created by the user.
    # @see CourseRegistrationRequest#requirer
    has_many :course_registration_requests

    # All {Permission permissions} given to the user through their role.
    # @return [Array<Permission>] a list of all permissions given to the user.
    has_many :permissions, through: :role

    # All {Question questions} created by the user.
    # @return [Array<Question>] a list of all questions created by the user.
    # @see Question#owner
    has_many :questions

    # All {Rating ratings} created by the user.
    # @return [Array<Rating>] a list of all ratings created by the user.
    # @see Rating#owner
    has_many :ratings

    # All {Recommendation recommendations} given by the user.
    # @return [Array<Recommendation>] a list of all recommendations given by the user.
    # @see Recommendation#user_source
    has_many :sent_recommendations, class_name: "Recommendation", foreign_key: "user_source_id"

    # All {Recommendation news} received by the user.
    # @return [Array<Recommendation>] a list of all recommendations received by the user.
    # @see Recommendation#user_destination
    has_many :received_recommendations, class_name: "Recommendation", foreign_key: "user_destination_id"

    # All {Response responses} created by the user.
    # @return [Array<Response>] a list of all responses created by the user.
    # @see Response#owner
    has_many :responses

    # All {Test tests} created by the user.
    # @return [Array<Test>] a list of all tests created by the user.
    # @see Test#owner
    has_many :tests

    # All {Course courses} in which the user takes part.
    # @return [Array<Course>] a list of all courses in which the user takes part.
    # @see Course#users
    has_many :courses, through: :user_courses

    # All {Subject subjects} in which the user has difficulties.
    # @return [Array<Subject>] a list of all subjects in which the user has difficulties.
    # @see Subject#users_in_difficulty
    has_many :difficult_subjects, class_name: "Subject", through: :category_difficulties, source: :category, source_type: "Subject"
    
    # All {Field fields} in which the user has difficulties.
    # @return [Array<Field>] a list of all fields in which the user has difficulties.
    # @see Field#users_in_difficulty
    has_many :difficult_fields, class_name: "Field", through: :category_difficulties, source: :category, source_type: "Field"
    
    # @!endgroup

    has_many :user_courses
    has_many :category_difficulties

    before_save :sanitize
  
    # Imports a new user.
    # @param [Hash] user_data Hash containing the user information.
    # @param [Role] user_role Role of the user.
    # @return [void]
    def self.import_user(user_data, user_role)

        # create new user object
        user = User.new

        # set role
        user.role = user_role

        # set fields
        user.email = user_data[:email]
        user.first_name = user_data[:first_name]
        user.last_name = user_data[:last_name]
        user.birthdate = user_data[:birthdate]
        user.password = "12345678"
    
        # save new user
        user.save!
    
    end

    def has_avatar
        avatar_file_name ? true : false
    end

    def avatar_url_thumb
        avatar.url(:thumb)
    end

    def avatar_url_medium
        avatar.url(:medium)
    end

    def verify_permissions(permission_list)
        user_permissions = permissions.map { |permission| permission.name }
        verified = {}
        permission_list.each do |permission|
            if user_permissions.include?(permission)
                verified[permission] = true
                user_permissions.delete(permission)
            else
                verified[permission] = false
            end
        end
        return verified
    end

    def confirm_permissions(permission_list)
        user_permissions = permissions.map { |permission| permission.name }
        permission_list.each do |permission|
            if !user_permissions.include?(permission)
                return false 
            end
        end
        return true
    end

    private

        def sanitize
            if self.birthdate.is_a?(String)
                self.birthdate = DateTime.parse(self.birthdate)
            end
        end

end
