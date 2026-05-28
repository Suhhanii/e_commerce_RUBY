require_relative "../dbconnection"

class UserService
  def self.get_category
    data = $db.query("select * from category")
    return data
  rescue => e
    puts "#{e} error while get category"
  end


  def self.get_all_products
    data = $db.query("SELECT p.*, c.name AS category_name 
                    FROM product p 
                    LEFT JOIN category c ON p.category_id = c.id")
  rescue => e
    puts "#{e} error while getting products"
  end


  def self.get_product_by_category(category)
    stmt = $db.prepare("select * from product where category_id = ?")
    data = stmt.execute(category)
    return data
  rescue => e
    puts "#{e} error while get products by category"
  end

  def self.get_product_by_id(id)
    stmt = $db.prepare("SELECT * from product where id = ?")
    data = stmt.execute(id)
  rescue => e
    puts "#{e} error while fetching product by id"
  end

  def self.place_order(data, user_id, grand_total)
  
    stmt = $db.prepare("INSERT INTO orders(user_id,total_amount) values(?,?)")
    stmt.execute(user_id, grand_total)

    order_id = $db.last_id

    data.each do |i|
      #inserting in order_item
      stmt = $db.prepare("INSERT INTO order_item(order_id,product_id,quantity,price,subtotal) values(?,?,?,?,?)")
      stmt.execute(order_id, i["id"], i["quantity"], i["price"].to_f.round(2), i['price'].to_f * i['quantity'].to_i)
      
      #get current product stock
      stmt = $db.prepare("select stock from product where id = ?")
      stock = stmt.execute(i["id"])&.first["stock"]

      #removing from product 
      stmt = $db.prepare("update product set stock = ? where id = ?")
      stmt.execute(stock-i["quantity"].to_i, i["id"])
    end

    stmt = $db.prepare("delete from cart where user_id = ?")
    stmt.execute($current_user.id)

    puts "Order Placed Successfully"
    CustomerUser.home
  rescue => e
    puts "There is an error while checkout #{e}"
  end

  def self.get_order_history
    stmt = $db.prepare("SELECT 
     o.id AS order_id,
     o.place_at,
     o.status AS order_status,
     p.name AS product_name,
     oi.quantity,
     oi.price AS unit_price,
     oi.subtotal,
     o.total_amount AS order_total
    FROM orders o
    JOIN order_item oi ON o.id = oi.order_id
    JOIN product p ON oi.product_id = p.id
    WHERE o.user_id = ?
    ORDER BY o.place_at DESC;
    ")
    data = stmt.execute($current_user.id)
    return data
  rescue => e
    puts "#{e.message}"
  end

  def self.cancel_order
    stmt = $db.prepare("update orders set status = 'Cancelled' where id = ?")
    stmt.execute($current_user.id)
    puts "Order cancel successfully"
  rescue => e
    puts "#{e.message}"
  end
end
