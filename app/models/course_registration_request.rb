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

class CourseRegistrationRequest < ActiveRecord::Base

	# References
	belongs_to :course
	belongs_to :user
	
end
