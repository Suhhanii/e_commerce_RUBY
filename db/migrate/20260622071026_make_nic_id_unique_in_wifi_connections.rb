class MakeNicIdUniqueInWifiConnections < ActiveRecord::Migration[8.1]
  def change
    remove_index :wifi_connections, :nic_id

    add_index :wifi_connections, :nic_id, unique: true
  end
end
