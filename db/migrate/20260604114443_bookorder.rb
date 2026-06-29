class Bookorder < ActiveRecord::Migration[8.1]
  def change
    create_table :book_ordr do  |t|
      t.string :string
      t.text :text

      t.timestamps
    end

  end
end
