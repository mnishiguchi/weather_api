# == Schema Information
#
# Table name: recordings
#
#  id          :integer          not null, primary key
#  temp        :integer
#  status      :string
#  location_id :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

require 'test_helper'

class RecordingTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
