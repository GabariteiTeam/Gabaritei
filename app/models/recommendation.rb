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
#  resource_id         :integer
#  resource_type       :string(255)
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#
# Indexes
#
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

	# @!endgroup

	
end
