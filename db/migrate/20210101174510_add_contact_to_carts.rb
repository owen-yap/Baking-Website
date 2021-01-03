class AddContactToCarts < ActiveRecord::Migration[6.0]
  def change
    add_column :carts, :name, :string
    add_column :carts, :contact, :string
    add_column :carts, :email, :string
  end
end
