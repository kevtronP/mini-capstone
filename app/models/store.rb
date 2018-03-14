class Store < ApplicationRecord

  validates :name, presence: true, uniqueness: true
  validates :price, presence: true, numericality: { greater_than: 0 }
  validates :description, length: { in: 10..500 }

  def is_discounted
    price <= 2
  end

  def tax
    price * 0.09
  end

  def total
    price + tax
  end

  def as_json
    {
    name: name,
    price: price,
    tax: tax,
    total: total,
    image_url: image_url,
    description: description,
    is_discounted: is_discounted
    }
  end

end
