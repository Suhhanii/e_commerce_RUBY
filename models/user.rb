require 'byebug'
class User
  attr_accessor :id,
                :uname,
                :pwd,
                :contact,
                :email,
                :type

  def initialize(data)
    @id = data["id"]
    @uname = data["uname"]
    @pwd = data["pwd"]
    @contact = data["contact"]
    @email = data["email"]
    @type = data["type"]
  end

  def self.show_products(data)
    table = Tabulo::Table.new(data) do |t|
      t.add_column("ID") { |row| row["id"] }
      t.add_column("Name") { |row| row["name"] }
      t.add_column("Category") { |row| row["category_id"] }
      t.add_column("Price") { |row| row["price"].to_f.round(2) }
      t.add_column("Stock") { |row| row["stock"] }
    end
    puts table
  end

  def admin?
    type == "admin"
  end

  def customer?
    type == "customer"
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

  def self.show_category(data)
    table = Tabulo::Table.new(data) do |t|
      t.add_column("ID") { |row| "#{row["id"]}"}
      t.add_column("Category") { |row| "#{row["name"]}"}
    end
    puts table
  end

  def self.show_user(data)
    table = Tabulo::Table.new(data) do |t|
      t.add_column("Id") { |row| "#{row["id"]}"}
      t.add_column("Name") { |row| "#{row["uname"]}"}
      t.add_column("Password") { |row| "#{row["pwd"]}"}
      t.add_column("Contact") { |row| "#{row["contact"]}"}
      t.add_column("Email") { |row| "#{row["email"]}"}
      t.add_column("Type") { |row| "#{row["type"]}"}
    end
    puts table
  end
end
