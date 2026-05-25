require_relative 'dbconnection'

class UserRepo

  def self.get_category
    $db = Dbconnection.connect()
    data = $db.query("select * from category")
  rescue => e
    puts "#{e} error while get category"
  ensure
    $db.close if $db
  end

  def self.get_all_products
    $db = Dbconnection.connect()
    data = $db.query("select * from product")
  rescue => e
    puts "#{e} error while get products"
  ensure
    $db.close if $db
  end

  def self.get_product_by_category(category)
    $db = Dbconnection.connect()
    stmt = $db.prepare("select * from product where category = ?")
    data = stmt.execute(category)
  rescue => e
    puts "#{e} error while get products by category"
  ensure
    $db.close if $db
  end 

end



