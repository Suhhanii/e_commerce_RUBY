require_relative 'dbconnection'

class User

  def self.get_category
    data = $db.query("select * from category")
  rescue => e
    puts "#{e} error while get category"
  end

  def self.get_all_products
    data = $db.query("select * from product")
  rescue => e
    puts "#{e} error while get products"
  end

  def self.get_product_by_category(category)
    stmt = $db.prepare("select * from product where category = ?")
    data = stmt.execute(category)
  rescue => e
    puts "#{e} error while get products by category"
  end 

  def self.get_product_by_id(id)
    stmt = $db.prepare("SELECT * from product where id = ?")
    data = stmt.execute(id);
  rescue => e
    puts "#{e} error while fetching product by id"
  end
end



