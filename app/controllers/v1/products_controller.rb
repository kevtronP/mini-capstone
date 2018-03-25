class V1::ProductsController < ApplicationController
  before_action :authenticate_admin, except:[:index, :show]

  def index
    products = Product.all

    search_terms = params[:q]
    if search_terms
      products = products.where("name ILIKE ?", "%#{search_terms}%")
    end

    i_should_sort_by_price = params[:sort_by_price]
    if i_should_sort_by_price
      products = products.order(price: :asc)
    else
      products = products.order(id: :asc)
    end

    input_category = params[:category]
    if input_category
      category = Category.find_by(name: input_category)
      products = category.products
    end

    render json: products.as_json
  end

  def create
    if current_user && current_user.admin
      product = Product.new(
        name: params[:name],
        price: params[:price],
        description: params[:description],
        supplier_id: 1
      )
      if product.save
        render json: product.as_json
      else
        render json: {}, status: :unauthorized
      end
    end
  end

  def show
    product = Product.find_by(id: params[:id])
    render json: product.as_json
  end

  def update
    product = Product.find_by(id: params[:id])
    product.name = params[:name] || product.name
    product.price = params[:price] || product.price
    product.description = params[:description] || product.description
    if product.save
      render json: product.as_json
    else
      render json: {}, status: :unauthorized
    end
  end

  def destroy
    product = Product.find_by(id: params[:id])
    product.destroy
    render json: {message: "Product successfully destroyed!"}
  end
end