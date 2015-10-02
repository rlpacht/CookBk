class ChangeRecipeColumn < ActiveRecord::Migration
  def change
    change_column :recipes, :time, 'integer USING CAST(time AS integer)'
  end
end
