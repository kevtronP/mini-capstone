class Store < ApplicationRecord

  validates :name, presence: true, uniqueness: true
  validates :price, presence: true, numericality: { greater_than: 0 }
  validates :description, length: { in: 10..500 }

  belongs_to :supplier
  has_many :images
  has_many :orders

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
    id: id,
    name: name,
    price: price,
    tax: tax,
    total: total,
    description: description,
    is_discounted: is_discounted,
    supplier: supplier.as_json,
    }
  end

end
