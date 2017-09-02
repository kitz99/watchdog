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
    last_price_value = @product.prices.last.value rescue ''
    if price
      if price < @product.min_actual_price
        @product.update_attributes(min_actual_price: price)
      end
      if price <= @product.min_desired_price
        PhonePostman.new(@product, "price changed from #{last_price_value} to #{price}. Possible buy!").deliver!
        Postman.new(@product, price).deliver!
      end
      if price.to_s != last_price_value.to_s
        PhonePostman.new(@product, "price changed from #{last_price_value} to #{price}").deliver!
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
