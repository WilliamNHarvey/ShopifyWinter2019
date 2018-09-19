class Product < ApplicationRecord
  belongs_to :shop
  has_many :line_items, dependent: :destroy

  after_save :update_line_items

  def set_line_items(ids)
    li_list = map_line_items_by_shop(ids)
    line_items = li_list
  end

  def add_line_items(ids)
    li_list = map_line_items_by_shop(ids)
    line_items << li_list
  end

  def update_line_items
    line_items.update_all(price: price, currency: currency)
  end

  private

  def map_line_items_by_shop(ids)
    ids.map do |item|
      current = LineItem.find_by(id: item)
      current.shop.id == shop.id ? current : nil
    end.compact
  end
end
