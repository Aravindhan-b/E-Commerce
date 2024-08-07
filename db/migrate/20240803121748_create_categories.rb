class CreateCategories < ActiveRecord::Migration[5.1]
  def change
    create_table :categories do |t|
      t.string :slug
      t.integer :parent_id, null: true

      t.timestamps
    end
  end
end
