require "open-uri"
require "faker"

puts "Clearing database..."
Review.destroy_all
Order.destroy_all
Product.destroy_all
User.destroy_all
Category.destroy_all

# Categories
categories = %w[breads cookies desserts cakes muffins sweets pastry rolls]
categories.each { |category| Category.create(name: category) }

# Seller
seller = User.new(email: "abc@gmail.com", password: "lewagon")
seller.username = "John Doe"
seller.address = "The Paterson, Singapore"
seller.seller = true
avatar_photo = URI.open("https://source.unsplash.com/300x400/?portrait")
seller.userphoto.attach(io: avatar_photo, filename: 'jpeg', content_type: 'image/jpeg')
seller.save!

seller2 = User.new(email: "123@gmail.com", password: "lewagon")
seller2.username = "Alice bakes"
seller2.address = "Orchard Towers, Singapore"
seller2.seller = true
avatar_photo = URI.open("https://source.unsplash.com/300x400/?portrait")
seller2.userphoto.attach(io: avatar_photo, filename: 'jpeg', content_type: 'image/jpeg')
seller2.save!

2.times do
  dessert = Faker::Dessert.variety
  product = Product.new(name: "#{Faker::Dessert.flavor} #{dessert}", description: "Soft and fluffy", price: (1..15).to_a.sample, category: "Pastry")
  product.user = seller
  product.category = Category.all.sample
  file = URI.open("https://source.unsplash.com/300x400/?#{dessert}")
  product.photo.attach(io: file, filename: 'jpeg', content_type: 'image/jpeg')
  product.save
end

2.times do
  dessert = Faker::Dessert.variety
  product = Product.new(name: "#{Faker::Dessert.flavor} #{dessert}", description: "Soft and fluffy", price: (1..15).to_a.sample, category: "Pastry")
  product.user = seller2
  product.category = Category.all.sample
  file = URI.open("https://source.unsplash.com/300x400/?#{dessert}")
  product.photo.attach(io: file, filename: 'jpeg', content_type: 'image/jpeg')
  product.save
end
#USer

buyer = User.new(email: "buyer@gmail.com", password: "lewagon")
buyer.username = "Roger"
buyer.address = "Ion Orchard, Singapore"
buyer.save!

product1 = Product.first

#Order
order1 = Order.new(status: "pending")
order1.product = product1
order1.user = buyer
order1.address = "221B Baker Street"
order1.quantity = 3
order1.save!

#Reviews

review1 = Review.new(content:"Great cupcakes", rating: 4)
review1.order = order1
review1.save!
