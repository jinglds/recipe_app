class CreateRecipes < ActiveRecord::Migration
  def change
    create_table :recipes do |t|
      t.text :name
      t.text :description
      t.integer :level
      t.text :course
      t.integer :prep_time
      t.integer :cook_time
      t.integer :serving
      t.text :ingredients
      t.text :directions
      t.text :privacy
      t.integer :user_id

      t.timestamps
    end
    add_index :recipes, [:user_id, :created_at]
    add_index :recipes, [:user_id, :created_at]
  end
end
