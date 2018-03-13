class Store < ApplicationRecord

  def is_discounted
    if price < 2
      p true
    else p false
    end
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
