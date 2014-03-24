class RemoveDirectionsFromRecipes < ActiveRecord::Migration
  def change
    remove_column :recipes, :directions, :string
  end
end
