# == Schema Information
#
# Table name: course_news
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  course_id  :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  text       :text
#  date       :datetime
#

class CourseNews < ActiveRecord::Base

	# References
	belongs_to :course
	belongs_to :user

end
