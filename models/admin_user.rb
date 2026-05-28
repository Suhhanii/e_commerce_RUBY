require "byebug"
require_relative "user"
require_relative "order"
require_relative "../Service/admin_service"
require_relative "../Service/user_service"

class AdminUser < User
  def self.home
    puts <<~DATA
           -----------------------
           1) For Add New Category
           2) For Add New Product
           3) For See All User
           4) For See All Admins
           5) For Remove Any User
           6) For Remove Any Product
           7) For Get All Product
           8) For See All Orders
           9) For Update Status Of Order
           10) For Get All Category
           11) For logout
           -----------------------
         DATA

    value = gets.chomp.to_i

    case value
    when 1
      puts "-----------------------"

      puts "Enter new Category Name"
      name = gets.chomp.downcase

      Admin.add_category(name)

      puts "-----------------------"
    when 2
      puts "-----------------------"

      puts "Enter Name Of Product"
      name = gets.chomp

      puts "Enter Id Of Category For Product"
      data = UserService.get_category
      User.show_category(data)
      category = gets.chomp.to_i

      puts "Enter price Of Product"
      price = gets.chomp

      puts "Enter Quantity Of Product"
      stock = gets.chomp

      puts "-----------------------"

      Admin.add_product(name, category, price, stock)
    when 3
      puts "-----------------------"
      data = Admin.see_all_user
      User.show_user(data)
    when 4
      data = Admin.see_only_admin
      User.show_user(data)
    when 5
      data = Admin.see_all_user
      User.show_user(data)

      puts "Enter User id"
      id = gets.chomp.to_i
      puts Admin.remove_user(id)
    when 6
      data = UserService.get_all_products
      User.show_products(data)

      puts "Enter Product Id"
      id = gets.chomp.to_i
      Admin.delete_product(id)
    when 7
      data = UserService.get_all_products
      User.show_products(data)
    when 8
      data = Admin.get_all_orders
      User.show_orders(data)
    when 9
      data = Admin.get_all_orders
      User.show_orders(data)
      
      AdminUser.show_status_menu
    when 10
      data = UserService.get_category
      User.show_category(data)
    when 11
      CLI.run
    else
      puts "Wrong Choice Please Try Again"
      AdminUser.home
    end
    AdminUser.home
  end

  def self.show_status_menu
    puts "Enter Order Id Which You Want To Update"
    
    order_id = gets.chomp.to_i
    @@order = Order.find_order_by_id(order_id)
    # byebug
    if @@order.nil?
      puts "Order not find by this ID: #{order_id}. Please enter a correct ID" 
      AdminUser.show_status_menu
    end

    if ["Delivered","Cancelled"].include?@@order.status
      puts "Order Already #{@@order.status}"
      AdminUser.show_status_menu
    end

    puts @@order.get_next_statuses_from

    
    value = gets.chomp.to_i
    unless @@order.valid_status_input?(value)
      puts "Wrong choise try again"
      AdminUser.show_status_menu
    end

    new_status = case value
                  when 1
                    "Pending"
                  when 2
                    "Confirmed"
                  when 3
                    "Packed"
                  when 4
                    "Shipped"
                  when 5
                    "Delivered"
                  else
                    "Cancelled"
                  end

    @@order.update_status(new_status)
  end
end
