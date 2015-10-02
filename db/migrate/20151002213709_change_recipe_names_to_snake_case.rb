class ChangeRecipeNamesToSnakeCase < ActiveRecord::Migration
  def change
    rename_column :recipes, :yummlyId, :yummly_id
    rename_column :recipes, :largeImgUrl, :large_img_url
    rename_column :recipes, :mediumImgUrl, :medium_img_url
    rename_column :recipes, :sourceUrl, :source_url
    rename_column :recipes, :numberOfServings, :number_of_servings
  end
end
