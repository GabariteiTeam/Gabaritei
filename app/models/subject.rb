# == Schema Information
#
# Table name: subjects
#
#  id          :integer          not null, primary key
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  name        :string(255)
#  description :text
#

class Subject < ActiveRecord::Base

	# Referenced by
	has_many :contents, as: :category
	has_many :courses, as: :category
	has_many :tests, through: :courses
  	has_many :teachers, through: :courses
	has_many :fields
  	has_many :question_categories, as: :category
  	has_many :user_deficit_categories, as: :category

end
