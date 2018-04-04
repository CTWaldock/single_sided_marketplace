class UpdateCarts < ActiveRecord::Migration[5.1]
  def change
    remove_column("carts", "price", :decimal)
    add_column("carts", "user_id", :integer)
    add_column("carts", "product_id", :integer)
  end
end
