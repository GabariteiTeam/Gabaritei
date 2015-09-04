# A person can request their registration in the system via a registration request. The data
# this object stores can then be used to create a new {User user}.
#
# == Schema Information
#
# Table name: registration_requests
#
#  id            :integer          not null, primary key
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  first_name    :string(255)
#  last_name     :string(255)
#  email         :string(255)
#  birthdate     :datetime
#  text          :text
#  response_date :datetime
#  response      :text
#  accepted      :boolean
#

class RegistrationRequest < ActiveRecord::Base

	# @!attribute first_name
	# 	First name of the requirer.
	# 	@return [String] the first name of the requirer.
	#
	# @!attribute last_name
	# 	Last name of the requirer
	# 	@return [String] the last name of the requirer.
	#  
	# @!attribute email
	# 	E-mail of the requirer
	# 	@return [String] the e-mail of the requirer.
	#  
	# @!attribute birthdate
	# 	Bithdate name of the requirer
	# 	@return [String] the birthdate of the requirer.
	#  	  
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

end
