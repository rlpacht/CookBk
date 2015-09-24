class ChangeRecipeColumn < ActiveRecord::Migration
  def change
    change_column :recipes, :time, :integer
  end
end
