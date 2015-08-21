# == Schema Information
#
# Table name: users
#
#  id         :integer          not null, primary key
#  role_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  first_name :string(255)
#  last_name  :string(255)
#  email      :string(255)
#  password   :string(255)
#  birthdate  :datetime
#  about      :text
#
# Indexes
#
#  index_users_on_role_id  (role_id)
#

require 'test_helper'

class UserTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
