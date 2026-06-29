class SubDevice < ApplicationRecord
  has_many :parts , class_name: "SubDevice", foreign_key: "device_id"
  belongs_to :device, class_name: "SubDevice", optional: true
end
