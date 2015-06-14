class CourseQuestion < ActiveRecord::Base
  
  belongs_to :question
  belongs_to :course
  
end