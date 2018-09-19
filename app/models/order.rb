class Order < ApplicationRecord
  belongs_to :shop
  has_many :order_items
  has_many :line_items, :through => :order_items, dependent: :destroy

  def set_price
    update_column(:price, line_items.sum(:price))
  end

  def set_line_items(ids)
    li_list = map_line_items_by_shop(ids)
    line_items = li_list
  end

  def add_line_items(ids)
    li_list = map_line_items_by_shop(ids)
    line_items << li_list
  end

  private

  def map_line_items_by_shop(ids)
    ids.map do |item|
      current = LineItem.find_by(id: item)
      current.shop.id == shop.id ? current : nil
    end.compact
  end
end
