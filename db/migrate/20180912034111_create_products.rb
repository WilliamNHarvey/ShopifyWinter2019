class CreateProducts < ActiveRecord::Migration[5.2]
  def change
    create_table :products do |t|
      t.string :name
      t.integer :shop_id, null: false
      t.decimal :price, precision: 8, scale: 2, default: 0
      t.string :currency, limit: 3, default: "CAD"

      t.timestamps
    end
  end
end
