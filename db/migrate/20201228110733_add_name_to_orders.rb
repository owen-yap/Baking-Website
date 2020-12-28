class AddNameToOrders < ActiveRecord::Migration[6.0]
  def change
    add_column :orders, :name, :string
    add_column :orders, :contact, :string
  end
end
