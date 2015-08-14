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
# Indexes
#
#  index_user_deficit_categories_on_category_id_and_category_type  (category_id,category_type)
#  index_user_deficit_categories_on_user_id                        (user_id)
#

class UserDeficitCategory < ActiveRecord::Base

	# References
	belongs_to :category, polymorphic: true
	belongs_to :user

end
