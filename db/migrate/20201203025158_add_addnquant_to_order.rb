class AddAddnquantToOrder < ActiveRecord::Migration[6.0]
  def change
    add_column :orders, :address, :text
    add_column :orders, :quantity, :integer
  end
end
