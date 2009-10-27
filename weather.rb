require 'rubygems'
require 'sinatra/base'
require 'yahoo-weather'
require 'mustache/sinatra'

module Weather
	class App < Sinatra::Base
		register Mustache::Sinatra
		
		set :views,     'templates/'
		set :mustaches, 'views/'
		
		enable :sessions

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
			mustache :index
		end

		post '/' do
			zipcode = params['zipcode']
			redirect '/' + zipcode.to_s
		end

		get %r{/(\d{5})} do |zipcode|
			weather = get_weather_info(zipcode)
			
			weather['title'] + '<p>' + weather['temp'].to_s + ' degrees; ' + weather['text'];
		end
	end
end