class CreatePrices < ActiveRecord::Migration[5.1]
  def change
    create_table :prices do |t|
      t.references :price, foreign_key: true
      t.float :value

      t.timestamps
    end
  end
end
