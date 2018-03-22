require "unirest"

print "Please enter your login email: "
input_email = gets.chomp
print "Please enter your password: "
input_password = gets.chomp

response = Unirest.post(
  "http://localhost:3000/user_token",
  parameters: {
    auth: {
      email: "#{input_email}",
      password: "#{input_password}"
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
puts "[2] See one product"
puts "[3] Add a Product"
puts "[4] Update a product"
puts "[5] Delete a product"
puts "[6] Create an Order"
puts "[7] Create a new account"

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
  print "Enter a product id: "
  product_id = gets.chomp
  response = Unirest.get("http://localhost:3000/v1/products/#{product_id}")
  product = response.body
  puts JSON.pretty_generate(product)

elsif input_option == "3"
  params ={}
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

elsif input_option == "4"
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
  
elsif input_option == "5"
  print "Enter a product id:"
  product_id = gets.chomp
  response = Unirest.delete("http://localhost:3000/v1/products/#{product_id}")
  puts "Product successfully deleted"

elsif input_option == "6"
  params = {}
  print "Enter a product id: "
  params[:product_id] = gets.chomp
  print "Enter a quantity: "
  params[:quantity] = gets.chomp
  response = Unirest.post("http://localhost:3000/v1/orders/", parameters: params)
  order = response.body
  puts JSON.pretty_generate(order)

elsif input_option == "7"
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
end