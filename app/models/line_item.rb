class LineItem < ApplicationRecord
  belongs_to :product
  belongs_to :shop
  has_many :order_items
  has_many :orders, :through => :order_items, dependent: :destroy

  after_save :set_price
  after_save :update_orders

  def set_price
    update_attributes(price: product.price, currency: product.currency)
  end

  def update_orders
    orders.each do |order|
      order.calculate_price
    end
  end
end