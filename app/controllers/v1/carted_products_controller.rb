class V1::CartedProductsController < ApplicationController
  before_action :authenticate_user

  def index
    carted_products = current_user.carted_products.where(status: "carted")
    render json: carted_products.as_json
  end
  
  def create
    if current_user
      cart = CartedProduct.new(
        user_id: current_user.id,
        product_id: params[:product_id],
        quantity: params[:quantity],
        status: "carted",
        )
      if cart.save
        render json: cart.as_json
      else
        render json: {}, status: :unauthorized
      end
    end
  end

  def destroy
    carted_product = CartedProduct.find_by(id: params[:id])
    carted_product.status = "removed"
    carted_product.save
    render json: {status: "Carted product successfully removed!"}
  end
end