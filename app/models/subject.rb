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
 has_many :questions
end
