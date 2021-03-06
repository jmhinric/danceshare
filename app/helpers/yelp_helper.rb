module YelpHelper
  def self.ask_for_theaters(venue_name, venue_address)
   
    YelpHelper::api_call_theaters(venue_name, venue_address)["businesses"].map do |venue|  
      {
        name:             venue["name"],
        display_address:  venue["location"]["display_address"].join("\n"),
        city:             venue["location"]["city"],
        state_code:       venue["location"]["state_code"],
        postal_code:      venue["location"]["postal_code"],
        image_url:        venue["image_url"],
        url:              venue["url"],
        rating_image_url: venue["rating_img_url"],
        yelp_id:          venue["id"],
        review_count:     venue["review_count"]
      }
    end
  end

  def self.api_call_theaters(venue_name, venue_address)
    search_theater = venue_name.gsub(" ", "+").gsub(",", "")
    search_location = venue_address.gsub(" ", "+").gsub(",", "")

    consumer_key = YELP_CONSUMER_KEY
    consumer_secret = "#{YELP_CONSUMER_SECRET}"
    token = "#{YELP_TOKEN}"
    token_secret = "#{YELP_TOKEN_SECRET}"

    api_host = 'api.yelp.com'

    consumer = OAuth::Consumer.new(consumer_key, consumer_secret, {:site => "http://#{api_host}"})
    access_token = OAuth::AccessToken.new(consumer, token, token_secret)

    path = "/v2/search?term=#{search_theater}+theater+performing+arts&location=#{search_location}&limit=5"
    
    JSON(access_token.get(path).body)
  end
end