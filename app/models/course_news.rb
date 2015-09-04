# A course news is an announcement that a {User user} can create and broadcast to all participants of a {Course course}.
#
# == Schema Information
#
# Table name: course_news
#
#  id         :integer          not null, primary key
#  owner_id   :integer
#  course_id  :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  title      :string(255)
#  text       :text
#  date       :datetime
#
# Indexes
#
#  index_course_news_on_course_id  (course_id)
#  index_course_news_on_owner_id   (owner_id)
#

class CourseNews < ActiveRecord::Base

	# @!attribute title
	# 	Title of the news.
	# 	@return [String] the title of the news.
	#  
	# @!attribute text 
	# 	Text of the news.
	# 	@return [String] the text of the news.
	#  
	# @!attribute date 
	# 	Publication date of the news.
	# 	@return [DateTime] the date in which the news has been published.	

	# @!group Belongs to

	# The {Course course} to which the news is published.
	# @return [Course] the course of publication of the news.
	# @see Course#course_news
	belongs_to :course
	
	# The owner is the {User user} who published the news.
	# @return [User] the user who published the news.
	# @see User#course_news
	belongs_to :owner, class_name: "User"

    # @!endgroup


end
