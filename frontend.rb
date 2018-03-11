require "unirest"

system "clear"
puts "Welcome to Store app! Choose an option:"
puts "[1] See all products"
puts "[2] See one product"
puts "[3] Add a Product"
puts "[4] Update a product"
puts "[5] Delete a product"

input_option = gets.chomp
if input_option == "1"
  response = Unirest.get("http://localhost:3000/v1/products")
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
  params["input_name"] = gets.chomp
  print "Price: "
  params["input_price"] = gets.chomp
  print "Image URL: "
  params["input_image_url"] = gets.chomp
  print "Description: "
  params["input_description"] = gets.chomp
  response = Unirest.post("http://localhost:3000/v1/products", parameters: params)
  product = response.body
  puts JSON.pretty_generate(product)
elsif input_option == "4"
  print "Enter a product id: "
  product_id = gets.chomp
  params = {}
  print "Name: (#{product["input_name"]})"
  params["input_name"] = gets.chomp
  print "Price: (#{product["input_price"]})"
  params["input_price"] = gets.chomp
  print "Image URL: (#{product["input_image_url"]})"
  params["input_image_url"] = gets.chomp
  print "Description: (#{product["input_description"]})"
  params["input_description"] = gets.chomp
  params.delete_if { |_key, value| value.empty? }
  response = Unirest.patch("http://localhost:3000/v1/products/#{product_id}", parameters: params)
  product = response.body
  puts JSON.pretty_generate(product)
elsif input_option == "5"
  print "Enter a product id:"
  product_id = gets.chomp
  response = Unirest.delete("http://localhost:3000/v1/products/#{product_id}")
  puts "Product successfully deleted"
end
# response = Unirest.get("http://localhost:3000/v1/all_products_url")
# products = response.body
# puts JSON.pretty_generate(products)