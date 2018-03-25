class CartedProduct < ApplicationRecord
  belongs_to :user
  belongs_to :order, optional: true
  belongs_to :product

  def as_json
    {
      id: id,
      product: product.as_json,
      quantity: quantity
    }
  end
end