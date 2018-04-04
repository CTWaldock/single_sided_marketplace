class CreateCarts < ActiveRecord::Migration[5.1]
  def change
    create_table :carts do |t|
      t.integer :qty
      t.decimal :price

      t.timestamps
    end
  end
end
