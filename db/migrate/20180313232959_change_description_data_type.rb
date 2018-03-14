class ChangeDescriptionDataType < ActiveRecord::Migration[5.1]
  def change
    change_column :stores, :description, :text
  end
end
