require 'httparty'
require 'json'

class EventFinder
  include HTTParty
  base_uri 'https://app.ticketmaster.com/discovery/v2/'

  def initialize(api_key)
    @api_key = api_key
  end

  def find_events(city)
    url = "/events.json?city=#{city}&apikey=#{@api_key}"
    response = self.class.get(url)

    if response.success?
      events = JSON.parse(response.body)
      events['_embedded']['events'].each do |event|
        name = event['name']
        venue = event['_embedded']['venues'][0]['name']
        date = event['dates']['start']['localDate']
        time = event['dates']['start']['localTime']
        
        puts "Event: #{name}"
        puts "Venue: #{venue}"
        puts "Date: #{date}"
        puts "Time: #{time}"
        puts "-" * 50
      end
    else
      puts "Failed to fetch events for #{city}."
    end
  end
end


api_key = '9NP6tBntQgPI7TnCeiXWk4Z04zxqd4fb'
event_finder = EventFinder.new(api_key)


city = 'Houston'
event_finder.find_events(city)