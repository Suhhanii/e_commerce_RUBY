require_relative '../repository/user'

class UserService
  def self.get_category
    User.get_category
  end

  def self.get_all_products
    User.get_all_products
  end

  def self.get_product_by_category(category)
    User.get_product_by_category(category)
  end

end