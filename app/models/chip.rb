class Chip < ApplicationRecord

  validates :date_of_expiry, comparison: { greater_than:
    :date_of_packing }

end
