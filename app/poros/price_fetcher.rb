require 'open-uri'
require 'open_uri_redirections'

class PriceFetcher
  include PriceBuilder

  def initialize(product)
    @product = product
  end

  def call
    url = @product.href
    @document = Nokogiri::HTML(open(url, allow_redirections: :safe))
    price = build_price(@document.xpath(@product.price_xpath))
    if price
      if price < @product.min_actual_price
        @product.update_attributes(min_actual_price: price)
      end
      if price <= @product.min_desired_price
        Postman.new(@product, price).deliver!
      end
      @product.prices << Price.new(value: price)
    end
  end

  private

  def build_price(raw)
    case @product.shop.name
    when 'Emag'
      build_emag_price(raw.first)
    when 'Elefant'
      build_elefant_price(raw.first)
    when 'MediaGalaxy'
      build_mg_price(raw.first)
    end
  end
end
