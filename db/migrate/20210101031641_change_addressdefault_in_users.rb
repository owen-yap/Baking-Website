class ChangeAddressdefaultInUsers < ActiveRecord::Migration[6.0]
  def change
    change_column :users, :address, :string, default: "Singapore"
  end
end
