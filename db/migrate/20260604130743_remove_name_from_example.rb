class RemoveNameFromExample < ActiveRecord::Migration[8.1]
  def change
    remove_column :examples, :name, :string
  end
end
