# == Schema Information
#
# Table name: tests
#
#  id         :integer          not null, primary key
#  course_id  :integer
#  user_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  name       :string(255)
#

class Test < ActiveRecord::Base
  
  belongs_to :course
  belongs_to :user
  has_many :question_tests
  has_many :questions, through: :question_tests
  
  has_one :subject, through: :course
  
end
