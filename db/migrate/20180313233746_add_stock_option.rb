class AddStockOption < ActiveRecord::Migration[5.1]
  def change
    add_column :stores, :in_stock, :boolean
  end
end
