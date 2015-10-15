require 'json'
require 'net/http'
# require 'httparty'
class Api::RecipesController < ApplicationController

  include HTTParty
  base_uri("http://api.yummly.com/v1/api")

  def index
    # TODO: Clean this up using a default hash
    if params[:query].nil?
      food_searched = ""
      page_count = "1"
      recipe_time_in_seconds = nil
    else
      food_searched = params[:query][:search]
      page_count = params[:query][:currentPage]
      recipe_time_in_seconds = params[:query][:maxRecipeTime].to_i * 60
    end

    results_per_page = 10

    results = search_yummly(food_searched, page_count, results_per_page, recipe_time_in_seconds)

    total_matches = results["totalMatchCount"]
    # TODO: Do this in a way that doesn't make a db query for each result
    search_results = results["matches"].map do |result|
      yummly_id = result["id"]
      recipe = Recipe.find_by({yummly_id: yummly_id})
      if recipe.nil?
        insert_recipe_from_yummly_search(result).json_with_note_ids
      else
        recipe.json_with_note_ids
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
      recipe: recipe.json_with_note_ids
    }
  end

  def update
    recipe = Recipe.find(params[:id])
    if !recipe.is_data_complete
      updata_recipe_from_yummly(recipe)
    end
    render json: {
      recipe: recipe.json_with_note_ids
    }
  end

  private

  # response from yummly search is structured differently
  # from the response from the search for an individual recipe request
  # this method adds the data from the search to the model to reduce number of queries
  def insert_recipe_from_yummly_search(yummly_search_result)

    recipe_info = {
      yummly_id: yummly_search_result["id"],
      name: yummly_search_result["recipeName"],
      time: yummly_search_result["totalTimeInSeconds"],
      small_img_url: yummly_search_result["imageUrlsBySize"]["90"],
      is_data_complete: false
    }
    Recipe.create(recipe_info)
  end

  def search_yummly(search_query, page_count, results_per_page = 10, recipe_time_in_seconds)
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

    # Only add the max time filter if the searched time is under 8 hours
    if recipe_time_in_seconds < 28800
      query_params[:query][:maxTotalTimeInSeconds] = recipe_time_in_seconds
    end
    self.class.get("/recipes", query_params)
  end

  def updata_recipe_from_yummly(recipe)
    yummly_id = recipe.yummly_id
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
      ingredients: JSON.generate(result["ingredientLines"]),
      number_of_servings: result["numberOfServings"],
      source_url: result["source"]["sourceRecipeUrl"],
      large_img_url: result["images"][0]["imageUrlsBySize"]["360"],
      medium_img_url: result["images"][0]["hostedMediumUrl"],
      is_data_complete: true
    }
    recipe.update(recipe_info)

  end
end
