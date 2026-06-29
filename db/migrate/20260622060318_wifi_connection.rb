class WifiConnection < ActiveRecord::Migration[8.1]
  def change
    create_table :wifi_connections do |t|
      t.string :name, null:false
      t.references :nic, null: false, foreign_key: true

      t.timestamps
    end
  end
end
