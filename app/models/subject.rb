# == Schema Information
#
# Table name: subjects
#
#  id            :integer          not null, primary key
#  name          :text
#  professor_id  :integer
#  department_id :integer
#  descricao     :text
#  created_at    :datetime
#  updated_at    :datetime
#

class Subject < ActiveRecord::Base
 
  has_many :question_subjects
  has_many :questions, through: :question_subjects
  has_many :courses
  has_many :tests, through: :courses
  
end
