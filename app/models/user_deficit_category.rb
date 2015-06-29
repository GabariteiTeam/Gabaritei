# == Schema Information
#
# Table name: user_deficit_categories
#
#  user_id       :integer
#  category_id   :integer
#  category_type :string(255)
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

class UserDeficitCategory < ActiveRecord::Base

	# References
	belongs_to :category, polymorphic: true
	belongs_to :user

end
