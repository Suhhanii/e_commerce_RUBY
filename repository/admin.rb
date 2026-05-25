require_relative 'dbconnection'

class AdminRepo

  def self.add_category(name)

    $db = Dbconnection.connect()

    stmt = $db.prepare("insert into category(name) values(?)")
    stmt.execute(name)
    "Addes Successfully"
  rescue => e
    puts "#{e} at Admin Repo"
  ensure
    $db.close if $db
  end

  def self.add_product(name,category,price,stock)
    $db = Dbconnection.connect()

    stmt = $db.prepare("insert into product(name,category,price,stock) values(?,?,?,?)")
    stmt.execute(name,category,price,stock)
  rescue => e
    puts "#{e} error at admin repo page while adding product"
  ensure
    $db.close if $db
  end

  def self.see_all_user
    $db = Dbconnection.connect()

    data = $db.query("select * from user");
  rescue => e
    puts "#{e} Error while fetching all users"
  ensure
    $db.close if $db
  end

  def self.see_only_admin
    $db = Dbconnection.connect()

    data = $db.query("select * from user where type = 'admin'")
  rescue => e
    puts "#{e} Error while fetching admins"
  ensure
    $db.close if $db
  end

  def self.remove_user(id,name)
    $db = Dbconnection.connect()

    stmt = $db.prepare("delete from user where id = ? AND uname = ?")
    stmt.execute(id,name)
    "User Deleted Successfully"
  rescue => e
    puts "#{e} Error while removing user"
  ensure
    $db.close if $db
  end

  def self.delete_product(id,name)
    $db = Dbconnection.connect()

    stmt = $db.prepare("delete from product where id = ? & name = ?")
    stmt.execute(id,name)

    "Product Deleted Successfully"
  rescue => e
    puts "#{e} Error while deleting product"
  ensure 
    $db.close id $db
  end
end
