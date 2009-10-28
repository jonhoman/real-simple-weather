require 'rubygems'
require 'sinatra/base'
require 'yahoo-weather'
require 'mustache/sinatra'
require 'Haml'

module Weather
	class App < Sinatra::Base
		register Mustache::Sinatra

		helpers do
			def get_weather_info(zipcode)
				client = YahooWeather::Client.new
				response = client.lookup_location(zipcode)
				title = response.title
				condition = response.condition
		
				{ 'title' => title, 'temp' => condition.temp, 'text' => condition.text }
			end
		end

		get '/' do 
			haml :index
		end

		post '/' do
			zipcode = params['zipcode']
			redirect '/' + zipcode.to_s
		end

		get %r{/(\d{5})} do |zipcode|
			@weather = get_weather_info(zipcode)
			haml :conditions
		end
	end
end