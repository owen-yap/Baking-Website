class AddDeliveryToCarts < ActiveRecord::Migration[6.0]
  def change
    add_column :carts, :delivery, :string, default: "self-collection"
    add_column :carts, :address, :text
  end
end
