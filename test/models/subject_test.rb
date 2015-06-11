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

require 'test_helper'

class SubjectTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
