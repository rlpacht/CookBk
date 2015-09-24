class AddRecipeAttributes < ActiveRecord::Migration
  def change
    change_table :recipes do |t|
      t.string :yummly_id
      t.string :recipe_name
      t.string :time
      t.string :source_url
      t.string :img_url
      t.string :number_of_servings
      t.string :ingredients
    end
  end
end
