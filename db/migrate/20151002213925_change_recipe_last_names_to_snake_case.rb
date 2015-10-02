class ChangeRecipeLastNamesToSnakeCase < ActiveRecord::Migration
  def change
    rename_column :recipes, :smallImgUrl, :small_img_url
  end
end
