# == Description
#
#
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
# Indexes
#
#  index_ratings_on_question_id  (question_id)
#  index_ratings_on_user_id      (user_id)
#

class Rating < ActiveRecord::Base
  
	
	belongs_to :question
	belongs_to :user
	
end
