class Shop < ApplicationRecord
  has_many :products, dependent: :destroy
  has_many :orders, dependent: :destroy
  has_many :line_items, -> { distinct }, through: :products
end
