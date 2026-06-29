class CreateExamples < ActiveRecord::Migration[8.1]
  def change
    create_table :examples do |t|
      t.string :ex
      t.integer :ex_id

      t.timestamps
    end
  end
end
