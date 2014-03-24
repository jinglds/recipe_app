class CreateIngredients < ActiveRecord::Migration
  def change
    create_table :ingredients do |t|
      t.string :item
      t.float :amount
      t.string :unit
      t.string :alternative
      t.integer :recipe_id

      t.timestamps
    end
  end
end
