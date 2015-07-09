# == Schema Information
#
# Table name: ratings
#
#  user_id     :integer
#  question_id :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  value       :integer
#

class Rating < ActiveRecord::Base
  
	# References
	belongs_to :question
	belongs_to :user
	
end
