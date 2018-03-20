class Image < ApplicationRecord

  belongs_to :images
  
  def as_json
    {
      id: id,
      image_url: image_url
    }
  end
end
