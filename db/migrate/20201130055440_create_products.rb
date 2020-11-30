class CreateProducts < ActiveRecord::Migration[6.0]
  def change
    create_table :products do |t|
      t.string :new
      t.string :create

      t.timestamps
    end
  end
end
