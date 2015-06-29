# == Schema Information
#
# Table name: course_contents
#
#  course_id   :integer
#  contents_id :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class CourseContent < ActiveRecord::Base

	# References
	belongs_to :content
	belongs_to :course

end
