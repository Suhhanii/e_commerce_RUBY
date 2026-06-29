class CreateNics < ActiveRecord::Migration[8.1]
  def change
    create_table :nics do |t|
      t.string :name
      t.references :laptop, null: false, foreign_key: true

      t.timestamps
    end
  end
end
