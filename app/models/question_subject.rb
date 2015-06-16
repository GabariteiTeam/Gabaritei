# == Schema Information
#
# Table name: question_subjects
#
#  question_id :integer
#  subject_id  :integer
#

class QuestionSubject < ActiveRecord::Base
  
  belongs_to :question
  belongs_to :subject
  
end
