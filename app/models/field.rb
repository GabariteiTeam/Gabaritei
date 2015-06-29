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