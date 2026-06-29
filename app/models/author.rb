class Author < ApplicationRecord
  has_many :books, inverse_of: :author # , dependent: :destroy_async#, before_add: :check_limit

  def check_limit(_book)#Rails is forcing this argument into my method, but I am choosing to ignore it because I don't need it right now.
    puts "before add callback trigger"
    if books.count >=20
      errors.add(:base, "maximum limit reached")
      throw :abort
    end
  end
end
