module PriceBuilder
  module_function

  def build_emag_price(raw)
    int = raw.children.first.text.strip
    dec = raw.children[1].text
    "#{int}.#{dec}".to_f
  rescue
    nil
  end

  def build_elefant_price(raw)
    raw.text.gsub(',', '.').to_f
  rescue
    nil
  end

  def build_mg_price(raw)
    raw.text.strip.gsub(" lei", '').gsub('.', '').gsub(',', '.').to_f
  rescue
    nil
  end
end