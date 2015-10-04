class CreateApiNotes < ActiveRecord::Migration
  def change
    create_table :notes do |t|

      t.timestamps null: false
      t.string :text
      t.integer :recipe_id
      t.integer :user_id
    end
  end
end
