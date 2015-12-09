# A course registration request is a request a {User user} can create when they want to be registered in a {Course course}.
#
# == Schema Information
#
# Table name: course_registration_requests
#
#  id            :integer          not null, primary key
#  requirer_id   :integer
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
#  index_course_registration_requests_on_course_id    (course_id)
#  index_course_registration_requests_on_requirer_id  (requirer_id)
#

class CourseRegistrationRequest < ActiveRecord::Base

	# @!attribute text
	# 	Text of the request.
	# 	@return [String] the text of the request.
	#  
	# @!attribute response_date 
	# 	Date of the response.
	# 	@return [DateTime] the date in which the request was treated.
	#  
	# @!attribute response
	# 	Response of the request.
	# 	@return [String] the response text.	
	#
	# @!attribute accepted
	# 	Whether the request has been accepted or refused.
	# 	@return [String] "true" if the request has been accepted, "false" if refused.	

	# @!group Belongs to

	# The {Course course} to which the {CourseRegistrationRequest#requirer requirer} requests their registration.
	# @return [Course] the target course of the request.
	# @see Course#course_registration_requests
	belongs_to :course
	
	# The requirer is the {User user} who requests their registration to the {CourseRegistrationRequest#course course}.
	# @return [User] the requirer of the request.
	# @see User#course_registration_requests
	belongs_to :requirer, class_name: "User"

    # @!endgroup

	def status
		if response_date == nil
			return "requests.index.table.body.status.not_yet_treated"
		else
			if accepted
				return "requests.index.table.body.status.accepted_in"
			else
				return "requests.index.table.body.status.rejected_in"
			end
		end
	end
	
end
