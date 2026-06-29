class AddNameToExample < ActiveRecord::Migration[8.1]
  def change
    add_column :examples, :name, :string
  end
end
