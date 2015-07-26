require 'json'

class SearchController < ApplicationController
	skip_before_filter :verify_authenticity_token

	def google_image
		@base_url = 'https://www.googleapis.com/customsearch/v1'
		@key = '?key=' + ENV['GOOGLE_API_KEY']
		@cx = '&cx=' + ENV['GOOGLE_CX']

		@raw_text = params[:text]
		@trigger_word = params[:trigger_word]
		@text = @raw_text[@trigger_word.length+1..@raw_text.length].gsub(' ', '+')

		@query = '&q=' + @text
		@type = '&searchType=image&imgSize=large'

		@url = @base_url + @key + @cx + @query + @type

		@response = HTTParty.get(@url)
		@result = JSON.parse(@response.body)

		if @result['items']
			render json: {'text' => @result['items'].first['link']}, status: 200
		else
			render json: {'text' => 'Nothing found!'}, status: 200
		end
	end
end
