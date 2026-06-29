class CreateLaptops < ActiveRecord::Migration[8.1]
  def change
    create_table :laptops do |t|
      t.string :name

      t.timestamps
    end
  end
end
