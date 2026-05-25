require_relative '../repository/user'

class User
  def self.get_category
    UserRepo.get_category
  end

  def self.get_all_products
    UserRepo.get_all_products
  end

  def self.get_product_by_category(category)
    UserRepo.get_product_by_category(category)
  end

end