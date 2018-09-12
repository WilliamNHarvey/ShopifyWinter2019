# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

shop = Shop.create(name: "Demo Shop")
products = Product.create([{price: 2, shop: shop}, {price: 10.50, shop: shop}])
line_items = LineItem.create([{product: products[0]}, {product: products[1]}])
order = Order.create(shop: shop, line_items: line_items)