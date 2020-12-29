class ChangeAddressInUsers < ActiveRecord::Migration[6.0]
  def change
    change_column :users, :address, :string, default: "-"
  end
end
