class CreateLineItems < ActiveRecord::Migration[5.2]
  def change
    create_table :line_items do |t|
      t.integer :product_id, null: false
      t.decimal :price, precision: 8, scale: 2, default: 0
      t.string :currency, limit: 3, default: "CAD"

      t.timestamps
    end

    add_index :line_items, :product_id
  end
end
