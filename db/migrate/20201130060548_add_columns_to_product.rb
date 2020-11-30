class AddColumnsToProduct < ActiveRecord::Migration[6.0]
  def change
    add_column :products, :name, :string
    add_column :products, :description, :string
    add_column :products, :price, :integer
    add_column :products, :types, :string
    add_reference :products, :user_id, null: false, foreign_key: true
  end
end
