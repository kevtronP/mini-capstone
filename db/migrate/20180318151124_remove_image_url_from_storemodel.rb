class RemoveImageUrlFromStoremodel < ActiveRecord::Migration[5.1]
  def change
    remove_column :stores, :image_url, :string
  end
end
