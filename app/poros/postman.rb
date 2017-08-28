class Postman
  def initialize(product, min_price, to: Figaro.env.my_mail, from: 'your-watchdog@no-replay.com', subject: 'Check this out')
    @to = to
    @from = from
    @subject = subject
    @product = product
    @min_price = min_price
  end

  def deliver!
    body = "Check this out!\n Product: <a href='#{@product.href}'>#{@product.name}</a> \n Min Price: #{@min_price}"
    response = `curl -s --user 'api:#{Figaro.env.mail_api_key}' \
           #{Figaro.env.mail_api_url} \
          -F from=#{@from} \
          -F to=#{@to} \
          -F subject='#{@subject}' \
          -F text='#{body}'`
    message = JSON.parse(response).fetch("message", "Failed")
    return message == "Queued. Thank you."
  end
end
