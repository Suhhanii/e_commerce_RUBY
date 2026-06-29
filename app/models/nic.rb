class Nic < ApplicationRecord
  belongs_to :laptop
  has_one :wifi_connection, dependent: :destroy
end
