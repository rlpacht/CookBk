require 'json'
require 'net/http'
# require 'httparty'
class Api::RecipesController < ApplicationController

  include HTTParty
  base_uri("http://api.yummly.com/v1/api")

  def index
    if params[:query].nil?
      food_searched = ""
      page_count = "1"
    else
      food_searched = params[:query][:search]
      page_count = params[:query][:currentPage]
    end
    results_per_page = 10

    results = search_yummly(food_searched, page_count, results_per_page)

    search_results = []
    total_matches = results["totalMatchCount"]

    results["matches"].each do |result|
      yummly_id = result["id"]
      recipe = Recipe.find_by({yummly_id: yummly_id})
      if recipe.nil?
        search_results.push(find_and_insert_recipe(yummly_id))
      else
        search_results.push(recipe)
      end
    end

    render json: {
      recipes: search_results,
      meta: {
        total_matches: total_matches,
        results_per_page: results_per_page
      }
    }
  end

  def show
    recipe = Recipe.find(params[:id])
    render json: {
      recipe: recipe,
      notes: recipe.notes.where(user_id: current_user.id)
    }
  end

  private

  def search_yummly(search_query, page_count, results_per_page = 10)
    recipe_start = ((page_count.to_i) - 1) * results_per_page
    id = ENV["yummly_app_id"]
    key = ENV["yummly_app_key"]

    query_params = {
      query: {
        _app_id: id,
        _app_key: key,
        q: search_query,
        requirePictures: true,
        maxResult: results_per_page,
        start: recipe_start
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
      name: result["name"],
      ingredients: JSON.generate(result["ingredientLines"]),
      number_of_servings: result["numberOfServings"],
      time: result["totalTimeInSeconds"],
      source_url: result["source"]["sourceRecipeUrl"],
      small_img_url: result["images"][0]["imageUrlsBySize"]["90"],
      large_img_url: result["images"][0]["imageUrlsBySize"]["360"],
      medium_img_url: result["images"][0]["hostedMediumUrl"]
    }
    Recipe.create(recipe_info)

  end
end