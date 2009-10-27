module Views
	class Conditions < Mustache
	
		def initialize(title, temp, text)
			@conditions = { 'title' => title,
											'temp'  => temp,
											'text'  => text }
		end
		def title 
			@conditions['title']
		end
		
		def temp
			@conditions['temp']
		end
		
		def text
			@conditions['text']
		end
	end
end
