# == Schema Information
#
# Table name: tests
#
#  id          :integer          not null, primary key
#  course_id   :integer
#  user_id     :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  name        :string(255)
#  description :text
#
# Indexes
#
#  index_tests_on_course_id  (course_id)
#  index_tests_on_user_id    (user_id)
#

class Test < ActiveRecord::Base
  
	
 	belongs_to :course
 	belongs_to :user

 	
  	has_many :test_questions
  	has_many :questions, through: :test_questions
  	has_many :test_responses
  	has_many :responses, through: :test_responses

end
