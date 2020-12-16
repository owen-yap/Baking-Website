class AddSessionidToCarts < ActiveRecord::Migration[6.0]
  def change
    add_column :carts, :checkout_session_id, :string
  end
end
