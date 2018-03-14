class ChangePriceToDecimal < ActiveRecord::Migration[5.1]
  def change
    change_column :stores, :price, :decimal, precision: 10, scale: 2
  end
end
