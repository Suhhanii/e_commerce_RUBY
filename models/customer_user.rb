require_relative "user"
require_relative "../Service/user_service"
require_relative "../Service/cart_service"
require_relative "../dbconnection"
require_relative "order"
require_relative "category"
require_relative "product"
require 'byebug'
require 'tabulo'

class CustomerUser < User
  def self.home
    puts $data['customer_menu']
    value = gets.chomp.to_i

    case value
    when 1
      data = Category.get_category
      Category.show_category(data)
    when 2
      data = Product.get_all_products
      Product.show_products(data)
    when 3
      puts  "---------------------"
      data = Category.get_category
      Category.show_category(data)

      puts "Enter Category Id"
      category = gets.chomp.to_i
      data = Product.get_product_by_category(category)
      unless data.first
        puts "----------There Is No Product Found for Selected Category----------"
      else
        Product.show_products(data)
      end
    when 4
      data = CartService.open_cart

      unless data.first
        puts "---------Cart is Empty----------"
      else
        CustomerUser.show_user_cart(data)
      end
    when 5
      data = Product.get_all_products
      Product.show_products(data)
      puts "Enter Product Id"
      id = gets.chomp.to_i
      puts "Enter Quantity For the Product"
      quantity = gets.chomp.to_i
      response = CartService.add_to_cart(id, quantity)
      puts response
    when 6
      puts "Enter Product id which you want to remove"
      id = gets.chomp.to_i
      puts CartService.remove_from_cart(id)
    when 7
      data = Order.get_order_history

      unless data.first
        puts "There Is No Order History"
      else
        data = Order.get_order_history
        Order.show_orders(data)
      end
      
    when 8
      CLI.run
    else
      puts "Wrong Choice Please Try Again"
    end
    self.home
  end

  def self.show_user_cart(data)
      puts "-------------Cart Data-------------"
      
      table = Tabulo::Table.new(data) do |t|
        t.add_column("ID") { |row| row["id"] }
        t.add_column("Name") { |row| row["name"] }
        t.add_column("Price") { |row| row["price"].to_f.round(2) }
        t.add_column("Quantity") { |row| row["quantity"] }
        t.add_column("Sub Total") { |row| row["price"].to_f * row["quantity"].to_i }
      end

      puts table
      grand_total = data.sum do |row|
        row["price"].to_f * row["quantity"].to_i
      end

      puts "\nGrand Total: ₹#{grand_total.round(2)}"
      CustomerUser.checkout(data, grand_total)
   
  end

  def self.checkout(data, grand_total)
    puts <<~MENU
           1) For Checkout
           2) Continue Shoping
         MENU

    value = gets.chomp.to_i

    case value
    when 1
      if is_safe_to_place_order?(data)
        Order.place_order(data, $current_user.id, grand_total)
      else
        CustomerUser.home
      end
    when 2
      CustomerUser.home
    else
      puts "Wrong Choise Try  Again"
      self.checkout
    end
  end

  def self.order_menu
    puts $data['order_menu']
    value = gets.chomp.to_i

    case value
    when 1
      Order.cancel_order
    when 2
      UserService.home
    else
      puts "Wrong choise try Again"
      CustomerUser.order_menu
    end
  end

  def self.is_safe_to_place_order?(data)
    stmt = $db.prepare("select stock from product where id = ?")
    data.each do |row|
      stock = stmt.execute(row['id'].to_i)&.first['stock'].to_i

      unless stock
        puts "Product #{row['id']} is Out of Stock"
        return false
      end

      if stock < row['quantity'].to_i
        puts "Selected Quantity #{row['quantity']} is More than available stock of product #{row['id']}"
        return false
      end
    end
    true
  end
end
