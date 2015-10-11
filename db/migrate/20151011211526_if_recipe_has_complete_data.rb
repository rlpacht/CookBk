class IfRecipeHasCompleteData < ActiveRecord::Migration
  def change
    add_column :recipes, :is_data_complete, :boolean, null: false, default: false
  end
end
