# == Schema Information
#
# Table name: questions
#
#  id         :integer          not null, primary key
#  owner_id   :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  text       :text
#  answer     :text
#  hot        :boolean
#  source     :string(255)
#  date       :datetime
#  style      :string(255)
#
# Indexes
#
#  index_questions_on_owner_id  (owner_id)
#

require 'test_helper'

class QuestionTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
