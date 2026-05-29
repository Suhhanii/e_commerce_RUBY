require "tabulo"

class Order

  attr_accessor :id,
                :user_id,
                :status,
                :total_amount,
                :placed_at


  STATUS_MAP = {
    "pending"   => 1,
    "confirmed" => 2,
    "packed"    => 3,
    "shipped"   => 4,
    "delivered" => 5,
    "cancelled" => 6
  }.freeze

  def initialize(data)
    @id = data["id"]
    @user_id = data["user_id"]
    @status = data["status"]
    @total_amount = data["total_amount"]
    @placed_at = data["placed_at"]
  end

  def self.find_order_by_id(order_id)
    stmt = $db.prepare("select * from orders where id = ?")
    order = stmt.execute(order_id)&.first
    Order.new(order) unless order.nil?
  end

  def update_status(choice)
    new_status = STATUS_MAP.find { |_, value| value == choice}.first
    stmt = $db.prepare("update orders set status = ? where id = ?")
    stmt.execute(new_status, id)
    puts "Status updated successfully"
  rescue => e
    puts "#{e.message}"
  end 

  # Method 1: Focuses purely on filtering the allowed forward options
  def allowed_forward_statuses
    current_rank = STATUS_MAP[status.downcase]
    return {} if current_rank.nil?

    STATUS_MAP.select do |name, rank| 
      rank > current_rank && (name != "cancelled" || status.downcase != "delivered") 
    end
  end

  # Method 2: Focuses purely on formatting the filtered data for your terminal menu
  def get_next_statuses_from
    allowed_forward_statuses.map do |name, rank|
      "#{rank}) For #{name.capitalize}"
    end
  end

  def valid_status_input?(value)
    values = allowed_forward_statuses.values
    values.include?(value)
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
    # CustomerUser.home
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

  def self.show_orders(data)
    puts "\n---------------------------------- Your Order History ----------------------------------"

    table = Tabulo::Table.new(data) do |t|
      t.add_column("Order ID", width: 8) { |row| row["order_id"] }
      t.add_column("Date", width: 14)       { |row| row["place_at"] }
      t.add_column("Status", width: 8)    { |row| row["order_status"] }
      t.add_column("Product", width: 8)   { |row| row["product_name"] }
      t.add_column("Category", width: 8)   { |row| row["category_name"] }
      t.add_column("Qty", width: 5)        { |row| row["quantity"] }
      t.add_column("Unit Price", width: 8) { |row| "₹#{row['unit_price'].to_f.round(2)}" }
      t.add_column("Subtotal", width: 8)   { |row| "₹#{row['subtotal'].to_f.round(2)}" }
      t.add_column("Bill Total", width: 8) { |row| "₹#{row['order_total'].to_f.round(2)}" }
    end

    puts table
    puts "------------------------------------------------------------------------------------------\n"
  end
end
