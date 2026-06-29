class CreatePortraits < ActiveRecord::Migration[8.1]
  def change
    create_table :portraits do |t|
      t.string :poster
      t.decimal :price, precision: 10, scale: 2
      t.string :papertype

      t.timestamps
    end
  end
end
