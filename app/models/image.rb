class Image < ApplicationRecord

  belongs_to :product
  
  def as_json
    {
      id: id,
      image_url: image_url
    }
  end
end
