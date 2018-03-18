class Image < ApplicationRecord
  def as_json
    {
      id: id,
      image_url: image_url
    }
  end
end
