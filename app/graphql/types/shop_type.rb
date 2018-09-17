module Types
  class ShopType < Types::BaseObject
    field :id, ID, null: true
    field :name, String, null: true
    field :created_at, Int, null: true
    field :updated_at, Int, null: true

    field :products, [Types::ProductType], null: true do
      argument :id, ID, required: false
      argument :ids, [ID], required: false
    end

    def products(args = {})
      items ||= object.products
      if args[:id] || args[:ids]
        items.where(id: args[:id] || args[:ids])
      else
        items
      end
    end

    field :orders, [Types::OrderType], null: true do
      argument :id, ID, required: false
      argument :ids, [ID], required: false
    end

    def orders(args = {})
      items ||= object.orders
      if args[:id] || args[:ids]
        items.where(id: args[:id] || args[:ids])
      else
        items
      end
    end

    field :line_items, [Types::LineItemType], null: true do
      argument :id, ID, required: false
      argument :ids, [ID], required: false
    end

    def line_items(args = {})
      items ||= object.line_items
      if args[:id] || args[:ids]
        items.where(id: args[:id] || args[:ids])
      else
        items
      end
    end
  end
end
