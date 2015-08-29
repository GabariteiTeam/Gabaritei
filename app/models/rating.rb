# == Schema Information
#
# Table name: ratings
#
#  owner_id    :integer
#  question_id :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  value       :integer
#
# Indexes
#
#  index_ratings_on_owner_id     (owner_id)
#  index_ratings_on_question_id  (question_id)
#
class Rating < ActiveRecord::Base

	# @!attribute value
	# 	Value of the rating.
	# 	@return [Integer] the value of the rating.

	# @!group Belongs to

	# The rated {Question question}.
	# @return [Question] the rated question.
	belongs_to :question

	# The {User user} who gives the rating.
	# @return [User] the owner of the rating.
	belongs_to :owner, class_name: "User"

	# @!endgroup
	
end
