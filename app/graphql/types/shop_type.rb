module Types
  class ShopType < Types::BaseObject
    field :id, Int, null: true
    field :name, String, null: true, description: "The name of the shop"
    field :created_at, Int, null: true
    field :updated_at, Int, null: true

    field :products, [Types::ProductType], null: true, description: "The products in the shop. Can provide IDs to only get which of those products belong to the shop." do
      argument :id, [Int], required: false
    end

    def products(args = {})
      items = object.products
      if args[:id]
        items.where(id: args[:id])
      else
        items
      end
    end

    field :orders, [Types::OrderType], null: true, description: "The orders in the shop. Can provide IDs to only get which of those orders belong to the shop." do
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

    field :line_items, [Types::LineItemType], null: true, description: "The line items in the shop. Can provide IDs to only get which of those line items belong to the shop." do
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
