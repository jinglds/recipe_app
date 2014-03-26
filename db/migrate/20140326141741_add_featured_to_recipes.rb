class AddFeaturedToRecipes < ActiveRecord::Migration
  def change
    add_column :recipes, :featured, :boolean, default: false
  end
end
