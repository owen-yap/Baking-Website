class ChangeDeliveryFromOrders < ActiveRecord::Migration[6.0]
  def change
    change_column :orders, :delivery, :string, default: "self-collection"
  end
end
