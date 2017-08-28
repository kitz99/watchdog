namespace :products do
  desc "Fetch products prices"
  task :fetch_prices => [:environment] do
    Product.where(active: true).each do |product|
      PriceFetcher.new(product).call
      sleep 40
    end
  end

  desc "Email Notifier"
  task :send_notifications => [:environment] do
    Product.where(active: true).each do |product|
      if product.min_actual_price <= product.min_desired_price
        Postman.new(product, min_actual_price).deliver!
        sleep 15
      end
    end
  end
end
