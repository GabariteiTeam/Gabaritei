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

class QuestionCategory < ActiveRecord::Base

	# References
	belongs_to :category, polymorphic: true
	belongs_to :question 
	
end
