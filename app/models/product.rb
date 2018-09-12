class Product < ApplicationRecord
  belongs_to :shop
  has_many :line_items

  after_save :update_line_items

  def update_line_items
    line_items.update_all(price: price, currency: currency)
  end
end
