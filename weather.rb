require 'rubygems'
require 'sinatra'
require 'yahoo-weather'

helpers do
	def get_weather_info(zipcode)
		client = YahooWeather::Client.new
		response = client.lookup_location(zipcode)
		title = response.title
		condition = response.condition
		today = response.forecasts[0]
		day_one = response.forecasts[1]
		date_format = "%A %b %d"
		
		"#{title}<br />
		Now: #{condition.temp} degrees; #{condition.text}<br /><br />
		Forecast:<br />
		#{today.date.strftime(date_format)}  #{today.text}<br />
		High: #{today.high} degrees<br /> 
		Low: #{today.low} degrees
		<br /><br />
		
		#{day_one.date.strftime(date_format)}  #{day_one.text}<br />
		High: #{day_one.high} degrees<br /> 
		Low: #{day_one.low} degrees"
	end
end

get '/' do 
	'''
	<form action="/" method="post">
		Zip Code<input type="text" id="zipcode_input" name="zipcode" value="Enter a zipcode"/>
		<input type="submit" style="display: none" />
	</form>
	'''
end

post '/' do
  zipcode = params['zipcode']
  redirect '/' + zipcode.to_s
end

get %r{/(\d{5})} do |zipcode|
	get_weather_info(zipcode)
end
