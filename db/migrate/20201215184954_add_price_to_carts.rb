class AddPriceToCarts < ActiveRecord::Migration[6.0]
  def change
    add_monetize :carts, :price, currency: { present: false }
  end
end
