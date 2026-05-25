require_relative '../repository/admin'

class Admin
  def self.add_category(name)
    AdminRepo.add_category(name)
  end

  def self.add_product(name,category,price,stock)
    AdminRepo.add_product(name,category,price,stock)
  end

  def self.see_all_user
    AdminRepo.see_all_user
  end

  def self.see_only_admin
    AdminRepo.see_only_admin
  end

  def self.remove_user(id,name)
    AdminRepo.remove_user(id,name)
  end

  def self.delete_product(id,name)
    AdminRepo.delete_product(id,name)
  end

end
 