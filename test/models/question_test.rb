# == Schema Information
#
# Table name: questions
#
#  id         :integer          not null, primary key
#  user_id    :integer
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
#  index_questions_on_user_id  (user_id)
#

require 'test_helper'

class QuestionTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
