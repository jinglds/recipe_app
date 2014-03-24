class CreateDirections < ActiveRecord::Migration
  def change
    create_table :directions do |t|
      t.string :content
      t.integer :recipe_id

      t.timestamps
    end
  end
end
