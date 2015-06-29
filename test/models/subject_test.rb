# == Schema Information
#
# Table name: subjects
#
#  id          :integer          not null, primary key
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  name        :string(255)
#  description :text
#

require 'test_helper'

class SubjectTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
