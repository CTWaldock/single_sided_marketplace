class AddImgUrlToProducts < ActiveRecord::Migration[5.1]
  def change
    add_column :products, :img_url, :string
  end
end
