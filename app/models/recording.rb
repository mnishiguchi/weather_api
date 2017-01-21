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

class Recording < ApplicationRecord
  belongs_to :location
end
