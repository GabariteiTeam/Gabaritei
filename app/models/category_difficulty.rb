# == Schema Information
#
# Table name: category_difficulties
#
#  user_id       :integer
#  category_id   :integer
#  category_type :string(255)
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#
# Indexes
#
#  index_category_difficulties_on_category_id_and_category_type  (category_id,category_type)
#  index_category_difficulties_on_user_id                        (user_id)
#

class CategoryDifficulty < ActiveRecord::Base

    belongs_to :category, polymorphic: true
    belongs_to :user

end
