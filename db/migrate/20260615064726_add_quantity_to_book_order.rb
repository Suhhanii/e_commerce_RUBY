class AddQuantityToBookOrder < ActiveRecord::Migration[8.1]
  def change
    add_column :book_orders, :quantity, :integer
  end
end
