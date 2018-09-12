class Order < ApplicationRecord
  belongs_to :shop
  has_many :order_items
  has_many :line_items, :through => :order_items

  after_save :calculate_price

  def calculate_price
    update_column(:price, line_items.sum(:price))
  end
end
