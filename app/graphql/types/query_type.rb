module Types
  class QueryType < Types::BaseObject
    field :shops, [Types::ShopType], null: false, description: "Get shops. Can provide IDs or names to get only shops with those IDs or names." do
      argument :id, [Int], required: false
      argument :name, [String], required: false
    end

    def shops(args = {})
      if args[:id] && args[:name]
        Shop.where(id: args[:id], name: args[:name])
      elsif args[:id]
        Shop.where(id: args[:id])
      elsif args[:name]
        Shop.where(name: args[:name])
      else
        Shop.all
      end
    end

    field :all_shops, [Types::ShopType], null: false, description: "Get all shops."

    def all_shops
      Shop.all
    end

    field :products, [Types::ProductType], null: false, description: "Get products. Can provide IDs to get only products with those IDs." do
      argument :id, [Int], required: false
    end

    def products(args = {})
      get_by_class(args, Product)
    end

    field :all_products, [Types::ProductType], null: false, description: "Get all products."

    def all_products
      Product.all
    end

    field :orders, [Types::OrderType], null: false, description: "Get orders. Can provide IDs to get only orders with those IDs." do
      argument :id, [Int], required: false
    end

    def orders(args = {})
      get_by_class(args, Order)
    end

    field :all_orders, [Types::OrderType], null: false, description: "Get all orders."

    def all_orders
      Order.all
    end

    field :line_items, [Types::LineItemType], null: false, description: "Get line items. Can provide IDs to get only line items with those IDs." do
      argument :id, [Int], required: false
    end

    def line_items(args = {})
      get_by_class(args, LineItem)
    end

    field :all_line_items, [Types::LineItemType], null: false, description: "Get all line items."

    def all_line_items
      LineItem.all
    end

    def get_by_class(args = {}, klass)
      if args[:id]
        klass.where(id: args[:id])
      else
        klass.all
      end
    end
  end
end
