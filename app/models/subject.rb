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
	has_many :fields
	has_many :direct_courses, class_name: "Course", as: :category
	has_many :indirect_courses, class_name: "Course", through: :fields, source: :courses
	has_many :direct_contents, class_name: "Content", as: :category
	has_many :indirect_contents, class_name: "Content", through: :fields, source: :contents
	has_many :tests, through: :courses
  	has_many :teachers, through: :courses
  	has_many :question_categories, as: :category
  	has_many :user_deficit_categories, as: :category

  	def courses
  		direct_courses + indirect_courses
  	end

  	def contents
  		direct_contents + indirect_contents
  	end

end
