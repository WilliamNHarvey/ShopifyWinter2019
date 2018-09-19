module Types
  class MutationType < Types::BaseObject
    # Shops
    field :create_shop, Types::ShopType, null: false, description: "Create a shop" do
      argument :name, String, required: true
    end

    def create_shop(args = {})
      Shop.create(args)
    end

    field :create_shops, [Types::ShopType], null: false, description: "Create multiple shops" do
      argument :name, [String], required: true
    end

    def create_shops(args = {})
      Shop.create(args[:name].map { |n| Hash[name: n]})
    end

    field :edit_shop, Types::ShopType, null: false, description: "Edit a shop by ID" do
      argument :id, Int, required: true
      argument :name, String, required: false
    end

    def edit_shop(args = {})
      item = Shop.find_by(id: args[:id])
      if item
        item.update_attributes(args)
      end
      item
    end

    field :delete_shops, [Types::ShopType], null: false, description: "Delete shops by their ID's" do
      argument :id, [Int], required: true
    end

    def delete_shops(args = {})
      Shop.destroy(args[:id])
    end

    # Products
    field :create_product, Types::ProductType, null: false, description: "Create a product" do
      argument :shop, Int, required: true, as: :shop_id
      argument :price, Float, required: false
      argument :currency, String, required: false
      argument :line_items, [Int], required: false
    end

    def create_product(args = {})
      if args[:line_items]
        line_items = args[:line_items].map do |item|
          current = LineItem.find_by(id: item)
          current.shop.id == object.shop.id ? current : nil
        end.compact
        Product.create(args.merge({line_items: line_items}))
      else
        Product.create(args)
      end
    end

    field :edit_product, Types::ProductType, null: false, description: "Edit a product by id" do
      argument :id, Int, required: true
      argument :shop, Int, required: false, as: :shop_id
      argument :price, Float, required: false
      argument :currency, String, required: false
      argument :line_items, [Int], required: false
      argument :add_line_items, [Int], required: false
      argument :remove_line_items, [Int], required: false
    end

    def edit_product(args = {})
      item = Product.find_by(id: args[:id])
      scrub_params = [:line_items, :add_line_items, :remove_line_items]
      if item
        if args[:line_items]
          item.set_line_items(args[:line_items])
        end
        if args[:add_line_items]
          item.add_line_items(args[:add_line_items])
        end
        if args[:remove_line_items]
          item.line_items.delete(args[:remove_line_items])
        end
        item.update_attributes(args.except(*scrub_params))
      end
      item
    end

    field :delete_products, [Types::ShopType], null: false, description: "Delete products by their ID's" do
      argument :id, [Int], required: true
    end

    def delete_shops(args = {})
      Product.destroy(args[:id])
    end

    # Orders
    field :create_order, Types::OrderType, null: false, description: "Create an order" do
      argument :shop, Int, required: true, as: :shop_id
      argument :line_items, [Int], required: false
    end

    def create_order(args = {})
      if args[:line_items]
        line_items = args[:line_items].map do |item|
          current = LineItem.find_by(id: item)
          current.shop.id == object.shop.id ? current : nil
        end.compact
        Order.create(args.merge({line_items: line_items}))
      else
        Order.create(args)
      end
    end

    field :edit_order, Types::OrderType, null: false, description: "Edit an order by ID" do
      argument :id, Int, required: true
      argument :shop, Int, required: false, as: :shop_id
      argument :line_items, [Int], required: false
      argument :add_line_items, [Int], required: false
      argument :remove_line_items, [Int], required: false
    end

    def edit_order(args = {})
      item = Order.find_by(id: args[:id])
      scrub_params = [:line_items, :add_line_items, :remove_line_items]
      if item
        if args[:line_items]
          item.set_line_items(args[:line_items])
        end
        if args[:add_line_items]
          item.add_line_items(args[:add_line_items])
        end
        if args[:remove_line_items]
          item.line_items.delete(args[:remove_line_items])
        end
        item.update_attributes(args.except(*scrub_params))
      end
      item
    end

    field :delete_orders, [Types::OrderType], null: false, description: "Delete orders by ID's" do
      argument :id, [Int], required: true
    end

    def delete_orders(args = {})
      Order.destroy(args[:id])
    end

    # Line Items
    field :create_line_item, Types::LineItemType, null: false, description: "Create a line item" do
      argument :product, Int, required: true, as: :product_id
      argument :orders, [Int], required: false
    end

    def create_line_item(args = {})
      if args[:orders]
        orders = args[:orders].map { |item| Order.find_by(id: item) }.compact
        LineItem.create(args.merge({orders: orders}))
      else
        LineItem.create(args)
      end
    end

    field :edit_line_item, Types::LineItemType, null: false, description: "Edit a line item by ID" do
      argument :id, Int, required: true
      argument :product, Int, required: false, as: :product_id
      argument :orders, [Int], required: false
      argument :add_orders, [Int], required: false
      argument :remove_orders, [Int], required: false
    end

    def edit_line_item(args = {})
      item = LineItem.find_by(id: args[:id])
      scrub_params = [:orders, :add_orders, :remove_orders]
      if item
        if args[:orders]
          item.set_orders(args[:orders])
        end
        if args[:add_orders]
          item.add_orders(args[:add_orders])
        end
        if args[:remove_orders]
          item.orders.delete(args[:remove_orders])
        end
        item.update_attributes(args.except(*scrub_params))
      end
      item
    end

    field :delete_line_items, [Types::OrderType], null: false, description: "Delete line items by ID's" do
      argument :id, [Int], required: true
    end

    def delete_line_items(args = {})
      LineItem.destroy(args[:id])
    end
  end
end
