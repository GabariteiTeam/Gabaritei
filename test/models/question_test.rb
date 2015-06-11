# == Schema Information
#
# Table name: questions
#
#  id         :integer          not null, primary key
#  question   :text
#  year       :datetime
#  area       :string(255)
#  subject_id :integer
#  created_at :datetime
#  updated_at :datetime
#  hot        :boolean
#  style      :string(255)
#

require 'test_helper'

class QuestionTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
