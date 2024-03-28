require 'httparty'

def convert_currency(amount, from, to, api_key)
  url = "https://api.exchangerate-api.com/v4/latest/#{from}?api_key=#{api_key}"
  response = HTTParty.get(url)
  
  if response.success?
    rates = response.parsed_response['rates']
    exchange = rates[to]
    converted = exchange * amount
    puts "#{amount} #{from} is #{converted.round(2)} #{to} at a rate of #{exchange}."
  else
    puts "Failed to fetch exchange rates."
  end
end


api_key = 'a4c506d020f7c2938efb8f10'
convert_currency(100, 'USD', 'LEV', api_key)