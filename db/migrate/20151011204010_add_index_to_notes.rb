class AddIndexToNotes < ActiveRecord::Migration
  def change
    add_index :notes, :user_id
    add_index :notes, :recipe_id
  end
end
