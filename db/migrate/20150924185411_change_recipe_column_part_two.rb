class ChangeRecipeColumnPartTwo < ActiveRecord::Migration
  def change
    change_column :recipes, :number_of_servings, 'integer USING CAST(number_of_servings AS integer)'
  end
end
