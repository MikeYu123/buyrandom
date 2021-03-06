# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
product_seeds = YAML.load_file(Rails.root.join 'lib', 'seeds', 'products.yml')
products_array = product_seeds['products'].map{|_,v| v}
products = Product.create products_array
auction_service = InitAuctionService.new
products.each{|product| auction_service.create_auction product}