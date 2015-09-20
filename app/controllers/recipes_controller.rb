require 'net/http'
# require 'httparty'
class RecipesController < ApplicationController

  include HTTParty
  base_uri("http://api.yummly.com/v1/api")

	def index
    food_searched = params[:query]
    results = search_yummly(food_searched)
    # Loop through results
    # For ones that aren't in your db, add them to your db
    # Fetch recipes from your db which match ids with the search results
    # Ember expects {recipes: []}
	end

  private 

  def search_yummly(search_query)
    id = ENV["yummly_app_id"]
    key = ENV["yummly_app_key"]
    query_params = {
      query: {
        _app_id: id, 
        _app_key: key, 
        q: search_query
        # TODO: deal with page number 
      }
    }
    self.class.get("/recipes", query_params)
  end
end
