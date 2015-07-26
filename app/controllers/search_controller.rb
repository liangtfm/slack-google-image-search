require 'json'

class SearchController < ApplicationController
	def google_image
		puts params
		@base_url = 'https://www.googleapis.com/customsearch/v1'
		@key = '?key=' + ENV['GOOGLE_API_KEY']
		@cx = '&cx=' + ENV['GOOGLE_CX']
		@query = '&q=' + params[:text]
		@type = '&searchType=image&imgSize=medium'

		@url = @base_url + @key + @cx + @query + @type

		puts @url

		@response = HTTParty.get(@url)
		@result = JSON.parse(@response.body)

		puts @result

		if @result['items']
			render json: {'text' => @result['items'].first['link']}, status: 200
		else
			render json: {'text' => 'Nothing found!'}, status: 200
		end
	end
end
