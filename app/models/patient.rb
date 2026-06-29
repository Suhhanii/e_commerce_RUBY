class Patient < ApplicationRecord
  has_many :appointment
  has_many :physician, through: :appointment
end
