class AddImageToRecipes < ActiveRecord::Migration
  def change
  	add_column :recipes, :image_path, :string
  end
end
