module Types
  class ProductType < Types::BaseObject
    field :id, ID, null: true
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
