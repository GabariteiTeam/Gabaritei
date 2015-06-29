class CourseContent < ActiveRecord::Base

	# References
	belongs_to :content
	belongs_to :course

end