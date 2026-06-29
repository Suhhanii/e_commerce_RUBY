class Picture < ApplicationRecord
  belongs_to :image, polymorphic: true
end
