class LineItem < ApplicationRecord
  belongs_to :product
  has_many :order_items
  has_many :orders, :through => :order_items, dependent: :destroy
  delegate :shop, to: :product

  after_save :set_price

  def set_price
    update_columns(price: product.price, currency: product.currency)
  end

  def set_orders(ids)
    order_list = map_orders_by_shop(ids)
    orders = li_list
  end

  def add_orders(ids)
    order_list = map_orders_by_shop(ids)
    orders << li_list
  end

  private

  def map_orders_by_shop(ids)
    ids.map { |item| Order.find_by(id: item, shop_id: shop.id) }.compact
  end
end
