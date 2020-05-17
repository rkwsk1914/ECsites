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

User.create(name: 'TEST-USER', email: 'test@exam.com', password:'testpass', password_confirmation:'testpass', address: '東京都新宿区西新宿２丁目８−１', payment: 'コンビニ支払い')