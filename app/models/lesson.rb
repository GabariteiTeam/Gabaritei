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

	include ActionView::Helpers::TextHelper
	include ActionView::Helpers::SanitizeHelper

	# @!attribute title
	# 	Title of the lesson.
	# 	@return [String] the name of the lesson.
	#  
	# @!attribute description  
	# 	Description of the lesson.
	# 	@return [String] the description of the lesson.

	belongs_to :course

	# List of all associated {Content contents} of the lesson.
    # @return [Array<Content>] all associated contents of the lesson.
    # @see Content#lessons
    has_many :contents, through: :lesson_contents
    has_many :questions, through: :lesson_questions

    has_many :lesson_contents
    has_many :lesson_questions, -> { order "updated_at ASC" }

    def timeline
    	lcontents = lesson_contents
    	lquestions = lesson_questions
    	ltimeline = []
    	lquestions.each_with_index do |lquestion, i|
    		ltimeline.push({
    			type: "question",
    			id: lquestion.question.id,
    			title: (i + 1).to_s,
    			description: strip_tags(truncate(lquestion.question.text, length: 50, escape: false)),
    			updated_at: lquestion.updated_at,
    			updated_at_string: lquestion.updated_at.strftime("%d/%m/%Y %H:%M")
    		})
    	end
    	lcontents.each do |lcontent|
    		ltimeline.push({
    			type: "content",
    			id: lcontent.content.id,
    			title: lcontent.content.name,
    			description: lcontent.content.description,
    			updated_at: lcontent.updated_at,
    			updated_at_string: lcontent.updated_at.strftime("%d/%m/%Y %H:%M")
    		})
    	end
    	ltimeline.sort! { |x, y| y[:updated_at] <=> x[:updated_at] }
    	return ltimeline
    end

end
