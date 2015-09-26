require 'json'
require 'net/http'
# require 'httparty'
class Api::RecipesController < ApplicationController

  include HTTParty
  base_uri("http://api.yummly.com/v1/api")

	def index
    
    food_searched = params[:query][:search]
    page_count = params[:query][:currentPage]
  
    results = search_yummly(food_searched, page_count)
    search_results = []
    total_matches = results["totalMatchCount"]
    results["matches"].each do |result|
      yummly_id = result["id"]
      if Recipe.exists?({yummlyId: yummly_id})
        search_results.push(Recipe.find_by({yummlyId: yummly_id}))
      else
        search_results.push(find_and_insert_recipe(yummly_id))
      end
    end
    # search_results.push(total_matches)

    render json: {recipes: search_results, total_matches: total_matches}
      
	end

  def search
    # this should take care of the search, not index,
    # because otherwise it'll perform a search each time 
    # a user goes to /recipes
  end

  def show
    recipe = Recipe.find(params[:id])
    render json: {recipe: recipe}
  end

  private 

  def search_yummly(search_query, page_count)
    recipe_start = ((page_count.to_i) - 1) * 10
    id = ENV["yummly_app_id"]
    key = ENV["yummly_app_key"]
    query_params = {
      query: {
        _app_id: id, 
        _app_key: key, 
        q: search_query,
        maxResult: 10,
        start: recipe_start

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
      yummlyId: result["id"],
      name: result["name"],
      ingredients: JSON.generate(result["ingredientLines"]),
      numberOfServings: result["numberOfServings"],
      time: result["totalTimeInSeconds"],
      sourceUrl: result["source"]["sourceRecipeUrl"],
      smallImgUrl: result["images"][0]["imageUrlsBySize"]["90"],
      largeImgUrl: result["images"][0]["imageUrlsBySize"]["360"],
      mediumImgUrl: result["images"][0]["hostedMediumUrl"]
    }
    Recipe.create(recipe_info)
  end
end
