class AddIndexToUserFavorites < ActiveRecord::Migration
  def change
    add_index :user_favorites, :user_id
    add_index :user_favorites, :recipe_id
  end
end
