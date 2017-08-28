namespace :products do
  desc "Fetch products prices"
  task :fetch_prices => [:environment] do
    puts "--->>>>> Start [#{Time.now.in_time_zone('Europe/Bucharest').strftime('%e %b %Y, %l:%M %p').strip}]"
    Product.where(active: true).each do |product|
      PriceFetcher.new(product).call
      sleep 40
    end
    puts "----------->>>>END \n\n"
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
