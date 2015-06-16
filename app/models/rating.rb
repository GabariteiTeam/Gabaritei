# == Schema Information
#
# Table name: ratings
#
#  id          :integer          not null, primary key
#  user_id     :integer
#  question_id :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  level       :integer
#  comment     :text
#

class Rating < ActiveRecord::Base
  
  belongs_to :user
  belongs_to :question
  
end
