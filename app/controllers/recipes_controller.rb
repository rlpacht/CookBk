require 'json'
require 'net/http'
# require 'httparty'
class RecipesController < ApplicationController

  include HTTParty
  base_uri("http://api.yummly.com/v1/api")

	def index
    food_searched = params[:query]
    results = search_yummly(food_searched)
    search_results = []
    results["matches"].each do |result|
      if Recipe.find_by({yummly_id: result["id"]}).nil?
        search_results.push(find_and_insert_recipe(result["id"]))
      else
        search_results.push(Recipe.find_by({yummly_id: result["id"]}))
      end
    end

    # render json: {recipes: search_results}

    respond_to do |f|
      f.json { render json: {recipes: search_results}}
      f.html
    end 
      
    # end
    # Loop through results
    # For each result, 
      # If the same yummly id exists in your database, move on
      # Otherwise, fetch it from yummly's API and insert it in your db (use find_and_insert_recipe function below)
      # Also store an array of just the yummly ids for the search results
    # Query recipes from your db which match ids with the search results (look into SQL "IN" condition)
    # Ember expects JSON response in the form {recipes: [{}, {}, {}]}
    # render json: {}
	end

  def search
    # this should take care of the search, not index,
    # because otherwise it'll perform a search each time 
    # a user goes to /recipes
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

  def find_and_insert_recipe(yummly_id)

    id = ENV["yummly_app_id"]
    key = ENV["yummly_app_key"]
    query_params = {
      query: {
        _app_id: id, 
        _app_key: key
      }
    }

    result = self.class.get("/recipe/#{yummly_id}", query_params)

    recipe_info = {
      yummly_id: result["id"],
      recipe_name: result["name"],
      ingredients: JSON.generate(result["ingredientLines"]),
      number_of_servings: result["numberOfServings"],
      time: result["totalTimeInSeconds"],
      source_url: result["source"]["sourceRecipeUrl"],
      img_url: result["images"][0]["imageUrlsBySize"]["90"],
      large_img_url: result["images"][0]["imageUrlsBySize"]["360"],
      medium_img_url: result["images"][0]["hostedMediumUrl"]
    }
    new_recipe = Recipe.create(recipe_info)
    new_recipe
  end
end
