# == Schema Information
#
# Table name: data_imports
#
#  id                :integer          not null, primary key
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  model             :integer
#  status            :integer          default(-1)
#  progress          :integer          default(0)
#  col_sep           :string(255)
#  data_file_name    :string(255)
#  data_content_type :string(255)
#  data_file_size    :integer
#  data_updated_at   :datetime
#

require 'test_helper'

class DataImportTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
