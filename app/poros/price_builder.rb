module PriceBuilder
  module_function

  def build_emag_price(raw)
    int = raw.children.first.text.strip
    dec = raw.children[1].text
    "#{int}.#{dec}".to_f
  end

  def build_elefant_price(raw)
    raw.text.gsub(',', '.').to_f
  end
end