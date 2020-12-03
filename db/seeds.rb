require "open-uri"
require 'pry-byebug'

puts "Clearing database..."
Review.destroy_all
Order.destroy_all
Product.destroy_all
User.destroy_all

# User
user = User.new(email: "abc@gmail.com", password: "123123")
user.username = "John Doe"
user.address = "The Paterson, Singapore"
user.save!

#Product

5.times do
  product = Product.new(name: "Cupcake", description: "Soft and fluffy", price: 15, category: "Pastry")
  product.user = user
  file = URI.open('https://source.unsplash.com/300x400/?Cupcake')
  product.photo.attach(io: file, filename: 'jpeg', content_type: 'image/jpeg')
  product.save
end

product1 = Product.first

#Order
order1 = Order.new(status: "pending")
order1.product = product1
order1.user = user
order1.save!

#Reviews

review1 = Review.new(content:"Great cupcakes", rating: 4)
review1.order = order1
review1.save!
