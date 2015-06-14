class Test < ActiveRecord::Base
  
  belongs_to :course
  belongs_to :user
  has_many :question_tests
  has_many :questions, through: :question_tests
  
  has_one :subject, through: :course
  
end