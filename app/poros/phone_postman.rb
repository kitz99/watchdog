require 'json'
class PhonePostman
  def initialize(product, body_fragment)
    @product = product
  end

  def deliver!
    data = {
      "to": Figaro.env.phone_token,
      "priority": "high",
      "notification":{
        "title": "Price change detected!",
        "sound": "default",
        "body": "For <<#{@product.name}>>, " + body_fragment
        }
      }
      RestClient.post("https://fcm.googleapis.com/fcm/send", data.to_json, headers)
  end

  private

  def headers
    {
      content_type: :json,
      :Authorization => "key=#{Figaro.env.firebase_api_key}"
    }
  end
end

