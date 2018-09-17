module Types
  class LineItemType < Types::BaseObject
    field :id, ID, null: false
    field :created_at, Int, null: true
    field :updated_at, Int, null: true
    field :price, String, null: true

    def price
      object.price
    end

    field :currency, String, null: true

    def currency
      object.currency
    end

    field :shop, Types::ShopType, null: true

    def shop
      object.shop
    end

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
  end
end
