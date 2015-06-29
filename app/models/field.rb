# == Schema Information
#
# Table name: fields
#
#  id          :integer          not null, primary key
#  subject_id  :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  name        :string(255)
#  description :text
#

class Field < ActiveRecord::Base

	# References
	belongs_to :subject

	# Referenced by
	has_many :contents, as: :category
	has_many :courses, as: :category
	has_many :question_categories, as: :category
	has_many :questions, through: :question_categories
	has_many :user_deficit_categories, as: :category
	
end
