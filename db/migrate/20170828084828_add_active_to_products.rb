class AddActiveToProducts < ActiveRecord::Migration[5.1]
  def change
    add_column :products, :active, :boolean, null: false, default: true
  end
end
