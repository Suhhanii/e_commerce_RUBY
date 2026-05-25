require_relative 'dbconnection'

class AdminRepo

  def self.add_category(name)


    stmt = $db.prepare("insert into category(name) values(?)")
    stmt.execute(name)
    "Addes Successfully"
  rescue => e
    puts "#{e} at Admin Repo"
  end

  def self.add_product(name,category,price,stock)

    stmt = $db.prepare("insert into product(name,category,price,stock) values(?,?,?,?)")
    stmt.execute(name,category,price,stock)
  rescue => e
    puts "#{e} error at admin repo page while adding product"
  end

  def self.see_all_user

    data = $db.query("select * from user");
  rescue => e
    puts "#{e} Error while fetching all users"
  end

  def self.see_only_admin

    data = $db.query("select * from user where type = 'admin'")
  rescue => e
    puts "#{e} Error while fetching admins"
  end

  def self.remove_user(id,name)

    stmt = $db.prepare("delete from user where id = ? AND uname = ?")
    stmt.execute(id,name)
    "User Deleted Successfully"
  rescue => e
    puts "#{e} Error while removing user"
  end

  def self.delete_product(id,name)
    stmt = $db.prepare("delete from product where id = ? and name = ?")
    stmt.execute(id,name)

    "Product Deleted Successfully"
  rescue => e
    puts "#{e} Error while deleting product"
  end
end
