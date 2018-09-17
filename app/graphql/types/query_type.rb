module Types
  class QueryType < Types::BaseObject
    field :shops, [Types::ShopType], null: false do
      argument :id, ID, required: false
      argument :ids, [ID], required: false
    end

    def shops(args = {})
      get_by_class(args, Shop)
    end

    field :all_shops, [Types::ShopType], null: false

    def all_shops
      Shop.all
    end

    field :products, [Types::ProductType], null: false do
      argument :id, ID, required: false
      argument :ids, [ID], required: false
    end

    def products(args = {})
      get_by_class(args, Product)
    end

    field :all_products, [Types::ProductType], null: false

    def all_products
      Product.all
    end

    field :orders, [Types::OrderType], null: false do
      argument :id, ID, required: false
      argument :ids, [ID], required: false
    end

    def orders(args = {})
      get_by_class(args, Order)
    end

    field :all_orders, [Types::OrderType], null: false

    def all_orders
      Order.all
    end

    field :line_items, [Types::LineItemType], null: false do
      argument :id, ID, required: false
      argument :ids, [ID], required: false
    end

    def line_items(args = {})
      get_by_class(args, LineItem)
    end

    field :all_line_items, [Types::LineItemType], null: false

    def all_line_items
      LineItem.all
    end

    def get_by_class(args = {}, klass)
      if args[:id] || args[:ids]
        klass.where(id: args[:id] || args[:ids])
      else
        klass.all
      end
    end

    # def all_shops_two
    #   # by default, don't include past events
      
    #   resolve ->(obj, args, ctx) {
    #     Shop.all # => false if no value was provided in the query
    #     # ...
    #   }
    # end

    # field :all_shops, ShopType, null: false do
    #   resolve -> (obj, args, ctx) {
    #     Shop.all
    #   }
    # end

    # field :shop, type: ShopType do
    #   #argument :id, Int
    #   #argument :name, String
    #   description "Read one shop by id, name, or read all"
    #   resolve ->(obj, args, ctx) {
    #     if ctx[:get]
    #       if args[:id]
    #         Shop.find(args[:id])
    #       elsif args[:name]
    #         Shop.find_by(name: args[:name])
    #       else
    #         Shop.all
    #       end
    #     else
    #       if args[:name]
    #         Shop.new(name: args[:name])
    #       else
    #         Shop.new
    #       end
    #     end
    #   } do 
    #     argument :id, ID, required: false
    #     argument :name, String, required: false
    #   end
    # end
    # field :order do
    #   argument :id, types.Int
    #   type OrderType
    #   description "Read one order by id, or read all"
    #   resolve ->(obj, args, ctx) {
    #     if args[:id]
    #       Order.find(args[:id])
    #     else
    #       Order.all
    #     end
    #   }
    # end
    # field :product do
    #   argument :id, types.Int
    #   type ProductType
    #   description "Read one product by id, or read all"
    #   resolve ->(obj, args, ctx) {
    #     if args[:id]
    #       Product.find(args[:id])
    #     else
    #       Product.all
    #     end
    #   }
    # end
    # field :line_item do
    #   argument :id, types.Int
    #   type LineItemType
    #   description "Read one line item by id, or read all"
    #   resolve ->(obj, args, ctx) {
    #     if args[:id]
    #       LineItem.find(args[:id])
    #     else
    #       LineItem.all
    #     end
    #   }
    # end
    field :test_field, String, null: false,
      description: "An example field added by the generator"
    def test_field
      "Hello World!"
    end
  end
end
