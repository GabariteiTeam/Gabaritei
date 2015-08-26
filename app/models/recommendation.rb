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

	
	belongs_to :resource, polymorphic: true
	belongs_to :user_destination, class_name: "User"
	belongs_to :user_source, class_name: "User"
	
end
