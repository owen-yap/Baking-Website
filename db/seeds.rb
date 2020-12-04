require "open-uri"

puts "Clearing database..."
Review.destroy_all
Order.destroy_all
Product.destroy_all
User.destroy_all

# Seller
seller = User.new(email: "abc@gmail.com", password: "123123")
seller.username = "John Doe"
seller.address = "The Paterson, Singapore"
seller.seller = true
seller.save!

5.times do
  product = Product.new(name: "Cupcake", description: "Soft and fluffy", price: (1..15).to_a.sample, category: "Pastry")
  product.user = seller
  file = URI.open('https://source.unsplash.com/300x400/?Cupcake')
  product.photo.attach(io: file, filename: 'jpeg', content_type: 'image/jpeg')
  product.save
end

#USer

buyer = User.new(email: "buyer@gmail.com", password: "123456")
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
