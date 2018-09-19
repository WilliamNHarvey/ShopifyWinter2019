module Types
  class OrderType < Types::BaseObject
    field :id, Int, null: true
    field :created_at, Int, null: true
    field :updated_at, Int, null: true
    field :price, String, null: true, description: "The price of the order"

    def price
      object.price
    end

    field :currency, String, null: true, description: "The currency of the order's price"

    def currency
      object.currency
    end

    field :shop, Types::ShopType, null: true, description: "The shop the order belongs to"

    def shop
      object.shop
    end

    field :line_items, [Types::LineItemType], null: true, description: "Get the line items belonging to the order. Can provide IDs to only get which of those line items belong to the order." do
      argument :id, [Int], required: false
    end

    def line_items(args = {})
      items = object.line_items
      if args[:id]
        items.where(id: args[:id])
      else
        items
      end
    end
  end
end
