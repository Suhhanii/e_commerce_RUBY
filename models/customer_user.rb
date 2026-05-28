require_relative "user"
require_relative "../Service/user_service"
require_relative "../Service/cart_service"
require_relative "../dbconnection"
require 'byebug'
require "tabulo"

class CustomerUser < User
  def self.home
    puts <<~MENU
           -----------------------
            1) For Get Category
            2) For Get All Products
            3) For Get Product By Category
            4) For Open Cart
            5) For Add Product into Cart
            6) For Remove Product From Cart
            7) For Check Order History"
            8) For Logout
           -----------------------
         MENU

    value = gets.chomp.to_i

    case value
    when 1
      data = UserService.get_category
      User.show_category(data)
    when 2
      data = UserService.get_all_products
      User.show_products(data)
    when 3
      puts  "---------------------"
      data = UserService.get_category
      User.show_category(data)

      puts "Enter Category Id"
      category = gets.chomp.to_i
      data = UserService.get_product_by_category(category)
      User.show_products(data)

    when 4
      data = CartService.open_cart

      unless data.first
        puts "---------Cart is Empty----------"
      else
        CustomerUser.show_user_cart(data)

      end
    when 5
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
      data = UserService.get_order_history

      unless data.first
        puts "There Is No Order History"
      else
        data = UserService.get_order_history
        User.show_orders(data)
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
      data.each do |i|
        stmt = $db.prepare("select * from product where id = ?")
        stock = stmt.execute(i["id"])&.first['stock']
        if stock >= i['quantity'].to_i
          UserService.place_order(data, $current_user.id, grand_total)
        elsif stock < i['quantity'].to_i
          puts "Quantity is more then stock"
        else
          puts "Out Of Stock"
        end
      end
    when 2
      CustomerUser.home
    else
      puts "Wrong Choise Try  Again"
      self.checkout
    end
  end

  def self.order_menu
    puts <<~MENU
    1) For Cancel Order
    2) Continue Shoping"
    MENU

    value = gets.chomp.to_i

    case value
    when 1
      UserService.cancel_order
    when 2
      UserService.home
    else
      puts "Wrong choise try Again"
      CustomerUser.order_menu
    end
  end
end
