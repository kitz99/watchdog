class AddNameToProduct < ActiveRecord::Migration[5.1]
  def change
    add_column :products, :name, :string, null: false
  end
end
