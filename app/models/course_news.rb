class CourseNews < ActiveRecord::Base

	# References
	belongs_to :course
	belongs_to :user

end