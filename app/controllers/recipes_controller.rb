require 'net/http'
class RecipesController < ApplicationController
  include HTTParty
  base_uri("http://api.yummly.com/v1/recipes?")
	def index
    # include HTTParty
    # base_uri("http://api.yummly.com/v1")
		p 'INSIDE INDEX'
	end

  def search
    food_searched = params[:food]
    query = {query: {
      _app_id: ENV["yummly_app_id"], 
      _app_key: ENV["yummy_app_key"], 
      q: food_searched, 
      max_results: 30
    }}

    p query
    
  end
end
