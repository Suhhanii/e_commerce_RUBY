class Product < ApplicationRecord
 after_commit ShowName
 has_one_attached :featured_image
 has_rich_text :description
 validates :name , presence: true

 after_validation :error_log

 has_many :pictures, as: :image




private
  def error_log
    if errors.any?
      puts "from callback #{errors.full_messages}"
    end
  end

end
