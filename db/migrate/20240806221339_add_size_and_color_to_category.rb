class AddSizeAndColorToCategory < ActiveRecord::Migration[7.0]
  def change
    add_column :categories, :size, :string, array: true, default: []
    add_column :categories, :color, :string, array: true, default: []
  end
end
