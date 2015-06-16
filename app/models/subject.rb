# == Schema Information
#
# Table name: subjects
#
#  id         :integer          not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  name       :string(255)
#

class Subject < ActiveRecord::Base
 
  has_many :question_subjects
  has_many :questions, through: :question_subjects
  has_many :courses
  has_many :tests, through: :courses
  has_many :contents
  
end
