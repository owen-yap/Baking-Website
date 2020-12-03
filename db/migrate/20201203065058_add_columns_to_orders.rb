class AddColumnsToOrders < ActiveRecord::Migration[6.0]
  def change
    add_monetize :orders, :amount, currency: { present: false }
    add_column :orders, :checkout_session_id, :string
  end
end
