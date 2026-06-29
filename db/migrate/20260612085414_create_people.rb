class CreatePeople < ActiveRecord::Migration[8.1]
  def change
    create_table :people do |t|
      t.string :name
      t.string :email
      t.integer :contact

      t.timestamps
    end
  end
end
