class AddRefToOrder < ActiveRecord::Migration[8.1]
  def change
    add_reference :book_orders, :book, null: false, foreign_key: true
  end
end
