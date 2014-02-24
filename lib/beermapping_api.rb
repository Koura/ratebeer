class BeermappingApi
  def self.places_in(city)
    city = city.downcase
    Rails.cache.fetch(city, :expires_in => 1.week, :race_condition_ttl => 10.minutes) { fetch_places_in(city)}
  end

  def self.find(id, city)
    places_in(city).select{ |p| p.id == id.to_s }.first
  end
  private

  def self.fetch_places_in(city)
     url = "http://stark-oasis-9187.herokuapp.com/api/"
    
     response = HTTParty.get "#{url}#{ERB::Util.url_encode(city)}"
     places = response.parsed_response["bmp_locations"]["location"]

     return [] if places.is_a?(Hash) and places['id'].nil?

     places = [places] if places.is_a?(Hash)
     places.inject([]) do | set, place |
       set << Place.new(place)
     end
   end
end