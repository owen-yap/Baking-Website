class AddReferenceToOrder < ActiveRecord::Migration[6.0]
  def change
    add_reference :orders, :product, null: false, foreign_key: true
    add_reference :orders, :user, null: false, foreign_key: true
    add_column :orders, :status, :string
  end
end
