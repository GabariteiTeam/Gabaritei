class Test < ActiveRecord::Base
  
  belongs_to :course
  has_many :questions_tests
  has_many :questions, through: :questions_tests
  
  has_one :subject, through: :course
  
end