# == Schema Information
#
# Table name: user_course_roles
#
#  user_id    :integer
#  course_id  :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_user_course_roles_on_course_id  (course_id)
#  index_user_course_roles_on_user_id    (user_id)
#

class UserCourse < ActiveRecord::Base

	# References
  	belongs_to :course
  	belongs_to :user
  	
end
