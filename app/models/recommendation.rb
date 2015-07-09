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

class Recommendation < ActiveRecord::Base

	# References
	belongs_to :resource, polymorphic: true
	belongs_to :user_destination, class_name: "User"
	belongs_to :user_source, class_name: "User"
	
end
