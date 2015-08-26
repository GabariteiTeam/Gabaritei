# == Schema Information
#
# Table name: course_news
#
#  id         :integer          not null, primary key
#  user_id    :integer
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
#  index_course_news_on_user_id    (user_id)
#

class CourseNews < ActiveRecord::Base

	belongs_to :course
	belongs_to :user

end
