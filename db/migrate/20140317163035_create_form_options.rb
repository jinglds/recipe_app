class CreateFormOptions < ActiveRecord::Migration
  def change
    create_table :form_options do |t|

      t.timestamps
    end
  end
end
