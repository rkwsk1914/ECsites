# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

(1..10).each do |number|
  Product.create(name:'test-produtcs-' + number.to_s, price: 3000, stock: 10, explanation: "This is test.これはテストデータです。", picture: nil, status: "SALE")
end

User.create(name: 'OWNER', email: 'owner@exam.com', password:'siteowner', password_confirmation:'siteowner')