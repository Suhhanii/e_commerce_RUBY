class AddCountToBookOrderk < ActiveRecord::Migration[8.1]
  def change
    add_column :book_orders, :count, :integer
  end
end
