require 'httparty'

def fetch_weather_data(city, api_key)
    url = "https://api.openweathermap.org/data/2.5/weather?q=#{city}&appid=#{api_key}"

    response = HTTParty.get(url)

    if response.success?
        weather = response.parsed_response
        temperature_fahrenheit = (weather['main']['temp'] - 273.15) * 9/5 + 32
        humidity = weather['main']['humidity']
        conditions = weather['weather'].first['description']
        puts "Current weather in #{city}:"
        puts "Temperature: #{temperature_fahrenheit.round(2)} degrees F, Humidity: #{humidity}%, Conditions: #{conditions}"
    else
        puts "Failed to fetch weather data for #{city}."
    end
end

api_key = '9f162d312f9a6fd48fce1e0357992657'
fetch_weather_data('Sofia', api_key)