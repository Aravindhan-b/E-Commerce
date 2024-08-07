class CreateProducts < ActiveRecord::Migration[5.1]
  def change
    create_table :products do |t|
      t.string :title
      t.text :description
      t.jsonb :variants, array: true, default: []
      t.references :category, foreign_key: true

      t.timestamps
    end
  end
end
