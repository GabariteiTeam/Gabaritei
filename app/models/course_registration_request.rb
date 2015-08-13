# == Schema Information
#
# Table name: course_registration_requests
#
#  id            :integer          not null, primary key
#  user_id       :integer
#  course_id     :integer
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  text          :text
#  response_date :datetime
#  response      :text
#  accepted      :boolean
#
# Indexes
#
#  index_course_registration_requests_on_course_id  (course_id)
#  index_course_registration_requests_on_user_id    (user_id)
#

class CourseRegistrationRequest < ActiveRecord::Base

	# References
	belongs_to :course
	belongs_to :user
	
end
