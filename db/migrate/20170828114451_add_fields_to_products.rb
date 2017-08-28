class AddFieldsToProducts < ActiveRecord::Migration[5.1]
  def change
    add_column :products, :min_actual_price, :float, null: false, default: 999_999.0
    add_column :products, :min_desired_price, :float, null: false, default: 0.0
  end
end
