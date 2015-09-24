class ChangeRecipeColumnPartTwo < ActiveRecord::Migration
  def change
    change_column :recipes, :number_of_servings, :integer
  end
end
