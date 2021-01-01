class ChangeUserReferenceInCarts < ActiveRecord::Migration[6.0]
  def change
    change_column :carts, :user_id, :bigint, null: true
  end
end
