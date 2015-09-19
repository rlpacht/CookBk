require 'net/http'
# require 'httparty'
class RecipesController < ApplicationController

  include HTTParty
  base_uri("http://api.yummly.com/v1/api")

	def index
    p 'INSIDE INDEX'
    food_searched = params[:query]
    search(food_searched)
	end

  private 

  def search(search_query)
    # food_searched = "chicken"
    query_params = {query: {
      _app_id: ENV["yummly_app_id"], 
      _app_key: ENV["yummy_app_key"], 
      q: search_query 
      # max_results: 30
    }}
    response = self.class.get("recipes", query_params)

    p response
  end
end
