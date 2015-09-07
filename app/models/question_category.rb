# This is an auxiliary model of a join table between {Question} and {Subject} or {Field}. It establishes the "many-to-many" relationship between these models.
# @see Question#categories
# @see Subject#questions
# @see Field#questions
#
# == Schema Information
#
# Table name: question_categories
#
#  id            :integer          not null, primary key
#  question_id   :integer
#  category_id   :integer
#  category_type :string(255)
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#
# Indexes
#
#  index_question_categories_on_category_id_and_category_type  (category_id,category_type)
#  index_question_categories_on_question_id                    (question_id)
#

class QuestionCategory < ActiveRecord::Base

	belongs_to :category, polymorphic: true
	belongs_to :question 
	
end
