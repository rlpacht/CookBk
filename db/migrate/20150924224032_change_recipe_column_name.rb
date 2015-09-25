class ChangeRecipeColumnName < ActiveRecord::Migration
  def change
    rename_column :recipes, :img_url, :smallImgUrl
    rename_column :recipes, :recipe_name, :name
  end
end
