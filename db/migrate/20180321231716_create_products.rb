class CreateProducts < ActiveRecord::Migration[5.1]
  def change
    create_table :products do |t|
      t.string :name
      t.integer :price
      t.text :description
      t.boolean :in_stock
      t.integer :supplier_id

      t.timestamps
    end
  end
end
