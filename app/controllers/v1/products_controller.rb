class V1::ProductsController < ApplicationController
  def index
    products = Store.all
    render json: products.as_json
  end

  def show
    product_id = params["id"]
    product = Store.find_by(id: product_id)
    render json: product.as_json
  end

  def create
    product = Store.new(
      name: params["input_name"],
      price: params["input_price"],
      image_url: params["input_image_url"],
      description: params["input_description"]
      )
    if product.save
      render json: product.as_json
    else render json: {errors: product.errors.full_messages}, status: :unprocessable_entity
    end
  end

  def update
    product_id = params["id"]
    product = Store.find_by(id: product_id)
    product.name = params["input_name"] || product.name
    product.price = params["input_price"] || product.price
    product.image_url = params["input_image_url"] || product.image_url
    product.description = params["input_description"] || product.description
    if product.save
      render json: product.as_json
    else render json: {errors: product.errors.full_messages}, status: :unprocessable_entity
    end
  end

  def destroy
    product_id = params["id"]
    product = Store.find_by(id: product_id)
    product.destroy
    render json: product.as_json
  end
end