require "unirest"

# print "Please enter your login email: "
# input_email = gets.chomp
# print "Please enter your password: "
# input_password = gets.chomp

response = Unirest.post(
  "http://localhost:3000/user_token",
  parameters: {
    auth: {
      email: "kevin@email.com",
      password: "password"
    }
  }
)

# Save the JSON web token from the response
jwt = response.body["jwt"]
# Include the jwt in the headers of any future web requests
Unirest.default_header("Authorization", "Bearer #{jwt}")

system "clear"
puts "Here is your jwt #{jwt}"
puts "Welcome to Store app! Choose an option:"
puts "[1] See all products"
puts "  [1b] Search by product name (pineapple)"
puts "[2]See products by category"
puts "[3] See one product"
puts "[4] Add a product to your cart"
puts "[5] Add a Product"
puts "[6] Update a product"
puts "[7] Delete a product"
puts "[8] Order all products in your cart"
puts "[9] Create a new account"
puts "[10] Show items in cart"
puts "[11] Delete item from cart"

input_option = gets.chomp

if input_option == "1"
  response = Unirest.get("http://localhost:3000/v1/products")
  products = response.body
  puts JSON.pretty_generate(products)

elsif input_option == "1b"
  response = Unirest.get("http://localhost:3000/v1/products?q=pineapple")
  products = response.body
  puts JSON.pretty_generate(products)

elsif input_option == "1c"
  response = Unirest.get("http://localhost:3000/v1/products?sort_by_price=true")
  products = response.body
  puts JSON.pretty_generate(products)

elsif input_option == "2"
  params = {}
  print "Enter a catagory id: "
  params[:category] = gets.chomp
  response = Unirest.get("http://localhost:3000/v1/products")
  products = response.body
  puts JSON.pretty_generate(products)

elsif input_option == "3"
  print "Enter a product id: "
  product_id = gets.chomp
  response = Unirest.get("http://localhost:3000/v1/products/#{product_id}")
  product = response.body
  puts JSON.pretty_generate(product)

elsif input_option == "4"
  params = {}
  print "Enter a product id to add to your cart: "
  params[:product_id] = gets.chomp
  print "Please enter a quantity for this product: "
  params[:quantity] = gets.chomp
  response = Unirest.post("http://localhost:3000/v1/carted_products", parameters: params)
  cart = response.body
  puts JSON.pretty_generate(cart)

elsif input_option == "5"
  params = {}
  print "Name: "
  params[:name] = gets.chomp
  print "Price: "
  params[:price] = gets.chomp
  print "Description: "
  params[:description] = gets.chomp
  response = Unirest.post("http://localhost:3000/v1/products", parameters: params)
  product = response.body
  if product["errors"]
    puts "Uh Oh! Something went wrong..."
    p product["errors"]
  else
    puts "Here is your product info"
    puts JSON.pretty_generate(product)
  end

elsif input_option == "6"
  print "Enter a product id: "
  product_id = gets.chomp
  response = Unirest.get("http://localhost:3000/v1/products/#{product_id}")
  product = response.body
  params = {}
  print "Name (#{product["name"]}): "
  params[:name] = gets.chomp
  print "Price (#{product["price"]}): "
  params[:price] = gets.chomp
  print "Description (#{product["description"]}): "
  params[:description] = gets.chomp
  params.delete_if { |_key, value| value.empty? }
  response = Unirest.patch("http://localhost:3000/v1/products/#{product_id}", parameters: params)
  product = response.body
  if product["errors"]
    puts "Uh Oh! Something went wrong..."
    p product["errors"]
  else
    puts "Here is your product info"
    puts JSON.pretty_generate(product)
  end
  
elsif input_option == "7"
  print "Enter a product id:"
  product_id = gets.chomp
  response = Unirest.delete("http://localhost:3000/v1/products/#{product_id}")
  puts "Product successfully deleted"

elsif input_option == "8"
  response  = Unirest.post("http://localhost:3000/v1/orders")
  order = response.body
  puts JSON.pretty_generate(order)

elsif input_option == "9"
  params = {}
  print "Enter your name: "
  params[:name] = gets.chomp
  print "Enter your email: "
  params[:email] = gets.chomp
  print "Enter your password: "
  params[:password] = gets.chomp
  print "Please confirm your password: "
  params[:password_confirmation] = gets.chomp
  response = Unirest.post("http://localhost:3000/v1/users/", parameters: params)
  user = response.body
  if user["errors"]
    puts "Uh Oh! Something went wrong..."
    p user["errors"]
  else
    puts "Account successfully created!"
  end

elsif input_option == "10"
  response = Unirest.get("http://localhost:3000/v1/carted_products")
  carted_products = response.body
  puts JSON.pretty_generate(carted_products)

elsif input_option == "11"
  print "Enter carted product id to remove from cart: "
  input_carted_product_id = gets.chomp
  response = Unirest.delete("http://localhost:3000/v1/carted_products/#{input_carted_product_id}")
  message = response.body
  puts JSON.pretty_generate(message)
end