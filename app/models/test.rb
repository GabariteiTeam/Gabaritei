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

class Test < ActiveRecord::Base
  
	# References
 	belongs_to :course
 	belongs_to :user

 	# Referenced by
  	has_many :test_questions
  	has_many :questions, through: :test_questions
  	has_many :test_responses
  	has_many :responses, through: :test_responses

end
