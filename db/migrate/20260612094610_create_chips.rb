class CreateChips < ActiveRecord::Migration[8.1]
  def change
    create_table :chips do |t|
      t.date :date_of_packing
      t.date :date_of_expiry

      t.timestamps
    end
  end
end
