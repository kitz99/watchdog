class RenamePriceColumn < ActiveRecord::Migration[5.1]
  def change
    rename_column :prices, :price_id, :product_id
  end
end
