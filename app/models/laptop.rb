class Laptop < ApplicationRecord
  has_one :nic, dependent: :destroy
  has_one :wifi_connection, through: :nic
end
