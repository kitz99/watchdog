class CreateProducts < ActiveRecord::Migration[5.1]
  def change
    create_table :products do |t|
      t.references :shop, foreign_key: true
      t.string :href
      t.string :price_xpath

      t.timestamps
    end
  end
end
