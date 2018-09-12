class CreateOrderItems < ActiveRecord::Migration[5.2]
  def change
    create_table :order_items, :id => false do |t|
      t.integer :order_id
      t.integer :line_item_id
    end
  end
end
