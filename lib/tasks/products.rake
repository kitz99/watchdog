namespace :products do
  desc "Fetch products prices"
  task :fetch_prices => [:environment] do
    Product.all.each do |product|
      PriceFetcher.new(product).call
      sleep 60
    end
  end
end