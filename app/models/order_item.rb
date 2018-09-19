class OrderItem < ApplicationRecord
  belongs_to :order
  belongs_to :line_item

  after_commit :calculate_order_price

  def calculate_order_price
    order.set_price
  end
end
