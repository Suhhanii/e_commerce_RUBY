class CreateBooks < ActiveRecord::Migration[8.1]
  def change
    create_table :books do |t|
      t.string :name
      t.integer :lock_version

      t.timestamps
    end
  end
end
