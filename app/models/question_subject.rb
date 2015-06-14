class QuestionSubject < ActiveRecord::Base
  
  belongs_to :question
  belongs_to :subject
  
end