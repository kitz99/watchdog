# == Schema Information
#
# Table name: products
#
#  id          :integer          not null, primary key
#  shop_id     :integer
#  href        :string
#  price_xpath :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  name        :string           not null
#

class Product < ApplicationRecord
  belongs_to :shop
  has_many :prices
end
