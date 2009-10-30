require 'rubygems'
require 'sinatra/base'
require 'yahoo-weather'
require 'mustache/sinatra'
require 'haml'
require 'sass'

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

		get '/style.css' do
			content_type 'text/css'
			sass :style 
		end

		get '/weather' do 
			haml :index
		end

		post '/weather' do
			zipcode = params['zipcode']
			redirect '/weather/' + zipcode.to_s
		end

		get %r{/weather/(\d{5})} do |zipcode|
			@weather = get_weather_info(zipcode)
			haml :conditions
		end
	end
end
