require 'open-uri'
require 'open_uri_redirections'

class PriceFetcher
  def initialize(product)
    @product = product
  end

  def call
    url = @product.href
    @document = Nokogiri::HTML(open(url, allow_redirections: :safe))
    price = build_price(@document.xpath(@product.price_xpath))
    @product.prices << Price.new(value: price)
  end

  private

  def build_price(raw)
    case @product.shop.name
    when 'Emag'
      build_emag_price(raw.first)
    end
  end

  def build_emag_price(raw)
    int = raw.children.first.text.strip
    dec = raw.children[1].text
    "#{int}.#{dec}".to_f
  end
end