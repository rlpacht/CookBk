class AddUserFavoriteProperties < ActiveRecord::Migration
  def change
    change_table :user_favorites do |t|
      t.integer :user_id
      t.integer :recipe_id
    end
  end
end
