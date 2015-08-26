# == Description
#
# This is an auxiliary model of a join table between {Course} and {Content}. It establishes the "many-to-many" relationship between these models.
# @see Course#contents
# @see Content#courses
#
# == Schema Information
#
# Table name: course_contents
#
#  course_id   :integer
#  contents_id :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
# Indexes
#
#  index_course_contents_on_contents_id  (contents_id)
#  index_course_contents_on_course_id    (course_id)
#

class CourseContent < ActiveRecord::Base

	belongs_to :content
	belongs_to :course

end
