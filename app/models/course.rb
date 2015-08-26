# == Schema Information
#
# Table name: courses
#
#  id            :integer          not null, primary key
#  category_id   :integer
#  category_type :string(255)
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  name          :string(255)
#  description   :text
#
# Indexes
#
#  index_courses_on_category_id_and_category_type  (category_id,category_type)
#

class Course < ActiveRecord::Base
  
    belongs_to :category, polymorphic: true  
    has_many :course_contents
    has_many :course_news
    has_many :course_questions
    has_many :course_registration_requests
    has_many :tests
    has_many :user_courses
    has_many :users, through: :user_courses

end
