class Book < ApplicationRecord
  # belongs_to :author, counter_cache: true
  belongs_to :author, inverse_of: :books#, counter_cache: :author_books
  # validates :author, presence: true
  # validates_associated :author
  has_many :orders

  # before_create :check_author_existance, if: :name_present?
  # before_create :check_author_existance, if: ->{name.present?}
  before_create :check_author_existance, if: ->(obj) {obj.name.present?}


  after_destroy do |variable|
    puts "Books Destroy"
  end


  private
  def check_author_existance
    # byebug
    puts "before_create callback "
  end

  def name_present?
    puts "name_present callback trigger"
    return self.name.present?
  end
end
