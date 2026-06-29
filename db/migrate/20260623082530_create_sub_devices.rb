class CreateSubDevices < ActiveRecord::Migration[8.1]
  def change
    create_table :sub_devices do |t|
      t.string :name
      t.belongs_to :device, foreign_key: { to_table: :sub_devices }

      t.timestamps
    end
  end
end
