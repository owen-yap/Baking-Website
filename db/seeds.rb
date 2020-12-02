require "open-uri"

puts "Clearing users..."
User.destroy_all
Product.destroy_all




user = User.new(email: "abc@gmail.com", password: "123123")
user.username = "JohnDoe"
user.address = "International Towers, Orchard"
user.save



5.times do
  product = Product.new(name: "Cupcake", description: "Soft and fluffy", price: 15, category: "Pastry")
  product.user = user
  file = URI.open('https://source.unsplash.com/300x400/?Cupcake')
  product.photo.attach(io: file, filename: 'jpeg', content_type: 'image/jpeg')
  product.save
end


