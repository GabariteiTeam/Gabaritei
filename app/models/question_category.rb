# == Schema Information
#
# Table name: question_categories
#
#  question_id   :integer
#  category_id   :integer
#  category_type :string(255)
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#
# Indexes
#
#  index_question_categories_on_category_id_and_category_type  (category_id,category_type)
#  index_question_categories_on_question_id                    (question_id)
#

class QuestionCategory < ActiveRecord::Base

	# References
	belongs_to :category, polymorphic: true
	belongs_to :question 
	
end
