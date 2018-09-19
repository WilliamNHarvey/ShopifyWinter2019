module Types
  class LineItemType < Types::BaseObject
    field :id, Int, null: true
    field :created_at, Int, null: true
    field :updated_at, Int, null: true
    field :price, String, null: true, description: "The price of the line item"

    def price
      object.price
    end

    field :currency, String, null: true, description: "The currency of the line item's price"

    def currency
      object.currency
    end

    field :shop, Types::ShopType, null: true, description: "The shop that the line item's product belongs to"

    def shop
      object.shop
    end

    field :product, Types::ProductType, null: true, description: "The product which the line item belongs to"

    def product
      object.product
    end

    field :orders, [Types::OrderType], null: true, description: "The orders which the line item belongs to. Can provide IDs to only get which of those orders contain the line item." do
      argument :id, [Int], required: false
    end

    def orders(args = {})
      items = object.orders
      if args[:id]
        items.where(id: args[:id])
      else
        items
      end
    end
  end
end
