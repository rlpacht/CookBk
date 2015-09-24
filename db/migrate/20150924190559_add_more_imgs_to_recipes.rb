class AddMoreImgsToRecipes < ActiveRecord::Migration
  def change
    change_table :recipes do |t|
      t.string :large_img_url
      t.string :medium_img_url
    end
  end
end
