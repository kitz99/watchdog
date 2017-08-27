# == Schema Information
#
# Table name: prices
#
#  id         :integer          not null, primary key
#  price_id   :integer
#  value      :float
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Price < ApplicationRecord
  belongs_to :product

  def printable_created_at
    created_at.in_time_zone("Europe/Bucharest").strftime("%e %b %Y, %l:%M %p").strip
  end
end
