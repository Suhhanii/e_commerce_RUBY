require_relative "../dbconnection"


class CartService
  def self.add_to_cart(product_id, quantity)
    data = CartService.get_product_by_id(product_id)

    $stock = 0

    data.each do |val|
      $stock = val["stock"]
    end

    if quantity > $stock
      return "Invalid Quantity Selected Please Try Again"
    end

    cart_data = existing_item(product_id)

    if cart_data && cart_data.any? # Verify that rows were actually returned from MySQL
      existing_quantity = 0
      cart_data.each do |val|
        existing_quantity = val["quantity"]
      end
      new_quantity = existing_quantity + quantity

      if new_quantity > $stock
        return "Cannot Add This Quantity total would exceed available Quantity"
      end

      stmt = $db.prepare("update cart set quantity = ? where user_id= ? and product_id = ?")
      stmt.execute(new_quantity, $current_user.id, product_id)
      "Added Successfully"
    else
      stmt = $db.prepare("insert into cart(product_id,quantity,user_id) values(?,?,?)")
      stmt.execute(product_id, quantity, $current_user.id)
      return "Added Successfully"
    end
  rescue => e
    puts "#{e} error while add to cart "
  end

  def self.existing_item(product_id)
    unless $current_user
      return nil
    else
      stmt = $db.prepare("select * from cart where user_id = ? and product_id = ?")
      data = stmt.execute($current_user.id, product_id)
      return data
    end
  rescue => e
    puts "#{e} error while check existing item"
  end


  def self.open_cart
    query = "select 
    p.id, p.name,p.price,c.quantity
    from cart c inner join product p on c.product_id = p.id where c.user_id = ?"
    stmt = $db.prepare(query)
    data = stmt.execute($current_user.id)
  rescue => e
    puts "#{e} error while open cart"
  end

  def self.remove_from_cart(product_id)
    stmt = $db.prepare("delete from cart where product_id = ? and user_id = ?")
    stmt.execute(product_id, $current_user.id)
    "Remove From Cart Successfully"
  rescue => e
    puts "#{e} error while removing from cart"
  end

  def self.get_product_by_id(id)
    stmt = $db.prepare("SELECT * from product where id = ?")
    data = stmt.execute(id);
  rescue => e
    puts "#{e} error while fetching product by id"
  end
end
