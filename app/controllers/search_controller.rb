require 'json'

class SearchController < ApplicationController
	def image
		@base_url = 'https://www.googleapis.com/customsearch/v1'
		@key = '?key=' + ENV['GOOGLE_API_KEY']
		@cx = '&cx=' + ENV['GOOGLE_CX']
		@query = '&q=' + params[:text]
		@type = '&searchType=image'

		@url = @base_url + @key + @cx + @query + @type

		@response = HTTParty.get(@url)
		@result = JSON.parse(@response.body)
		if @result['items']
			render json: @result['items'].first['link']
		else
			render json: 'Nothing found!'
		end
	end
end
