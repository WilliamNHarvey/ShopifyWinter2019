class OrderItem < ApplicationRecord
  belongs_to :order
  belongs_to :line_item
end
