class ChangeRecipeAttributeNames < ActiveRecord::Migration
  def change
    rename_column :recipes, :yummly_id, :yummlyId
    rename_column :recipes, :large_img_url, :largeImgUrl
    rename_column :recipes, :medium_img_url, :mediumImgUrl
    rename_column :recipes, :source_url, :sourceUrl
    rename_column :recipes, :number_of_servings, :numberOfServings
  end
end
