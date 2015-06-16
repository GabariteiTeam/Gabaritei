# == Schema Information
#
# Table name: responses
#
#  id          :integer          not null, primary key
#  question_id :integer
#  user_id     :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  text        :text
#  correction  :decimal(4, 2)
#

class Response < ActiveRecord::Base
  
  belongs_to :user
  belongs_to :question
  
end
