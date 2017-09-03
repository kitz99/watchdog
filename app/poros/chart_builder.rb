module ChartBuilder
  module_function

  def call(prices)
    data = {
      labels: prices.map(&:printable_created_at),
      datasets: [
        {
          label: "Price evolution",
          fillColor: "rgba(220,220,220,0.2)",
          strokeColor: "rgba(220,220,220,1)",
          pointColor: "rgba(220,220,220,1)",
          pointStrokeColor: "#fff",
          pointHighlightFill: "#fff",
          pointHighlightStroke: "rgba(220,220,220,1)",
          data: prices.map(&:value)
        }
      ]
    }

   [size, data.to_json]
  end

  def alternative(prices)
    result = [prices.first]
    start = prices.second
    last = prices.second
    prices[1..-1].each_with_index do |price, idx|
      if price.value == last.value
        last = price
      else
        result << OpenStruct.new(value: start.value, printable_created_at: "#{start.printable_created_at} - #{last.printable_created_at}")
        result << price
        start = prices[idx+2] rescue nil
        last = prices[idx+2] rescue nil
      end
    end
    if start.present? && last.present?
      result << OpenStruct.new(value: start.value, printable_created_at: "#{start.printable_created_at} - #{last.printable_created_at}")
    end

     data = {
       labels: result.map(&:printable_created_at),
       datasets: [
         {
           label: "Price evolution",
           fillColor: "rgba(220,220,220,0.2)",
           strokeColor: "rgba(220,220,220,1)",
           pointColor: "rgba(220,220,220,1)",
           pointStrokeColor: "#fff",
           pointHighlightFill: "#fff",
           pointHighlightStroke: "rgba(220,220,220,1)",
           data: result.map(&:value)
         }
       ]
     }

    [size, data.to_json]

  end

  def size
    {
      height: 250,
      width: 1100
    }
  end
end