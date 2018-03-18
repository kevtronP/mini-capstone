class AddsupplierId < ActiveRecord::Migration[5.1]
  def change
    add_column :stores, :supplier_id, :integer
  end
end
