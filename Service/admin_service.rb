require_relative "../dbconnection"


class Admin
  def self.add_category(name)
    stmt = $db.prepare("insert into category(name) values(?)")
    stmt.execute(name)
    puts "Added Successfully"
  rescue => e
    puts "#{e} at Admin Repo"
  end

  def self.add_product(name, category, price, stock)
    stmt = $db.prepare("insert into product(name,category_id,price,stock) values(?,?,?,?)")
    stmt.execute(name, category, price, stock)
    puts "Product Added Successfully"
  rescue => e
    puts "Please Enter Existing Category, Else Add New Category"
  end

  def self.see_all_user
    data = $db.query("select * from user")
  rescue => e
    puts "#{e} Error while fetching all users"
  end

  def self.see_only_admin
    data = $db.query("select * from user where type = 'admin'")
  rescue => e
    puts "#{e} Error while fetching admins"
  end

  def self.remove_user(id)
    stmt = $db.prepare("delete from user where id = ?")
    stmt.execute(id)
    puts "User Deleted Successfully"
  rescue => e
    puts "#{e} Error while removing user"
  end

  def self.delete_product(id)
    stmt = $db.prepare("delete from product where id = ?")
    stmt.execute(id)

    puts "Product Deleted Successfully"
  rescue => e
    puts "#{e} Error while deleting product"
  end

  def self.get_all_orders
    data = $db.query("SELECT 
      o.id AS order_id,
      o.place_at,
      o.status AS order_status,
      p.name AS product_name,
      c.name AS category_name,
      oi.quantity,
      oi.price AS unit_price,
      oi.subtotal,
      o.total_amount AS order_total
    FROM orders o
    JOIN order_item oi ON o.id = oi.order_id
    JOIN product p ON oi.product_id = p.id
    LEFT JOIN category c ON p.category_id = c.id
    ORDER BY o.place_at DESC;")
    return data
  rescue => e
    puts "#{e.message}"
  end
end
