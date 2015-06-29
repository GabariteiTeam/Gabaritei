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
#  password      :string(255)
#  birthdate     :datetime
#  text          :text
#  response_date :datetime
#  response      :text
#  accepted      :boolean
#

class RegistrationRequest < ActiveRecord::Base

end
