# A lesson is a sub-division of a {Course course}, that means, a {Course course} is an
# aggregation of lessons. A lesson can possess {Content contents}.
#
# == Schema Information
#
# Table name: lessons
#
#  id          :integer          not null, primary key
#  course_id   :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  title       :string(255)
#  description :text
#
# Indexes
#
#  index_lessons_on_course_id  (course_id)
#

class Lesson < ActiveRecord::Base

	# @!attribute title
	# 	Title of the lesson.
	# 	@return [String] the name of the lesson.
	#  
	# @!attribute description  
	# 	Description of the lesson.
	# 	@return [String] the description of the lesson.

	# List of all associated {Content contents} of the lesson.
    # @return [Array<Content>] all associated contents of the lesson.
    # @see Content#lessons
    has_many :contents, through: :lesson_contents

    has_many :lesson_contents

end
