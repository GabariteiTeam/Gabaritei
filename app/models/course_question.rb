class CourseQuestion < ActiveRecord::Base
  
	# References
	belongs_to :course
	belongs_to :question
  
end
