class CreateRecipes < ActiveRecord::Migration
  def change
    create_table :recipes do |t|
      t.string :name
      t.string :description
      t.integer :level
      t.string :course
      t.integer :cook_time
      t.integer :serving
      t.string :ingredients
      t.string :directions
      t.string :privacy
      t.string :image
      t.integer :user_id


      t.timestamps
    end
    add_index :recipes, [:user_id, :created_at]
  end
end
