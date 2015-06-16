# == Schema Information
#
# Table name: contents
#
#  id         :integer          not null, primary key
#  subject_id :integer
#  user_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  data       :binary
#

class Content < ActiveRecord::Base
  
  belongs_to :subject
  belongs_to :user
  
end
