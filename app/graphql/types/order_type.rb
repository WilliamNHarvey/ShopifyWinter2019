module Types
  class OrderType < Types::BaseObject
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
    # field :line_items, type: LineItemType, null: true do
    #   resolve -> (obj, args, ctx) {
    #     obj.line_items.to_a
    #   } do 
    #     argument :id, ID, required: false
    #   end
    # end
    # field :shop, type: ShopType do
    #   resolve -> (obj, args, ctx) {
    #     obj.shop
    #   } do 
    #     argument :id, ID, required: false
    #   end
    # end
    # field :updated_at do
    #   type Int

    #   resolve -> (obj, args, ctx) {
    #     obj.updated_at.to_i
    #   }
    # end
    # field :created_at do
    #   type Int

    #   resolve -> (obj, args, ctx) {
    #     obj.created_at.to_i
    #   }
    # end
  end
end
