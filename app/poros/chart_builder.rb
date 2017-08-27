module ChartBuilder
  module_function

  def call(prices)
    data = {
     labels: prices.map { |p| p.created_at.strftime("%e %b %Y, %l:%M %p") },
     datasets: [
       {
         label: "Price evolution",
         fillColor: "rgba(220,220,220,0.2)",
         strokeColor: "rgba(220,220,220,1)",
         pointColor: "rgba(220,220,220,1)",
         pointStrokeColor: "#fff",
         pointHighlightFill: "#fff",
         pointHighlightStroke: "rgba(220,220,220,1)",
         data: prices.map { |p| p.value }
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