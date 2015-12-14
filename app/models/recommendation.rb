# A {User user} can recommend a resource (a {Question question} or {Content content}) to another {User user} via 
# a recommendation object.
#
# == Schema Information
#
# Table name: recommendations
#
#  id                  :integer          not null, primary key
#  user_source_id      :integer
#  user_destination_id :integer
#  course_id           :integer
#  resource_id         :integer
#  resource_type       :string(255)
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#
# Indexes
#
#  index_recommendations_on_course_id                      (course_id)
#  index_recommendations_on_resource_id_and_resource_type  (resource_id,resource_type)
#  index_recommendations_on_user_destination_id            (user_destination_id)
#  index_recommendations_on_user_source_id                 (user_source_id)
#

class Recommendation < ActiveRecord::Base

	# @!group Belongs to
	
	# The resource is the {Question question} or {Content content} that is being recommended.
	# @return [Question, Content] the recommended question or content.
	# @see Question#recommendations
	# @see Content#recommendations
	belongs_to :resource, polymorphic: true

	# The target {User user} of the recommendation.
	# @return [User] the target user of the recommendation.
	# @see User#sent_recommendations
	belongs_to :user_destination, class_name: "User"
	
	# The source {User user} of the recommendation.
	# @return [User] the source user of the recommendation.
	# @see User#received_recommendations
	belongs_to :user_source, class_name: "User"

	belongs_to :course

	# @!endgroup

	def self.get_course_students(source_user_id, course_id, query)
    	User.where("(id != :source_user_id AND (first_name LIKE :query OR last_name LIKE :query OR email LIKE :query)) AND EXISTS (SELECT 1 FROM role_permissions, permissions WHERE role_permissions.role_id = users.role_id AND role_permissions.permission_id = permissions.id AND permissions.name = :permission_name) AND EXISTS (SELECT 1 FROM user_courses WHERE user_courses.user_id = users.id AND user_courses.course_id = :course_id)", {query: "%#{query}%", source_user_id: source_user_id, course_id: course_id.to_i, permission_name: 'permission.courses.take_part'})
    end

end
