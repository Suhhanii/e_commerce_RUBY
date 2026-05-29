require "byebug"
require_relative "user"
require_relative "order"
require_relative "../Service/admin_service"
require_relative "../Service/user_service"
require_relative "category"
require_relative 'product'

require 'yaml'

class AdminUser < User
  def self.home
    puts $data['admin_home']
    value = gets.chomp.to_i

    case value
    when 1
      puts "-----------------------"
      puts "Enter new Category Name"
      name = gets.chomp.downcase
      Category.add_category(name)
      puts "-----------------------"
    when 2
      puts "-----------------------"
      puts "Enter Name Of Product"
      name = gets.chomp
      puts "Enter Id Of Category For Product"
      data = Category.get_category
      Category.show_category(data)
      category = gets.chomp.to_i
      puts "Enter price Of Product"
      price = gets.chomp
      puts "Enter Quantity Of Product"
      stock = gets.chomp
      puts "-----------------------"
      Product.add_product(name, category, price, stock)
    when 3
      puts "-----------------------"
      data = User.see_all_user
      User.show_user(data)
    when 4
      data = User.see_all_user
      User.show_user(data)
      puts "Enter User id"
      id = gets.chomp.to_i
      puts User.remove_user(id)
    when 5
      data = Product.get_all_products
      User.show_products(data)
      puts "Enter Product Id"
      id = gets.chomp.to_i
      Product.delete_product(id)
    when 6
      data = Product.get_all_products
      Product.show_products(data)
    when 7
      data = Order.get_all_orders
      Order.show_orders(data)
    when 8
      data = Order.get_all_orders
      Order.show_orders(data)
      show_status_menu
    when 9
      data = Category.get_category
      User.show_category(data)
    when 10
      CLI.run
    else
      puts "Wrong Choice Please Try Again"
      home
    end
    home
  end

  def self.show_status_menu
    puts "Enter Order Id Which You Want To Update"
    
    order_id = gets.chomp.to_i
    @@order = Order.find_order_by_id(order_id)

    if @@order.nil?
      puts "Order not find by this ID: #{order_id}. Please enter a correct ID" 
      show_status_menu
    end

    if ["Delivered","Cancelled"].include?@@order.status
      puts "Order Already #{@@order.status}"
      show_status_menu
    end

    puts @@order.get_next_statuses_from
    choice = gets.chomp.to_i

    max_try = 3
    until @@order.valid_status_input?(choice)
      puts "Wrong choise try again. #{max_try} attempts remaining"
      choice = gets.chomp.to_i
      max_try -= 1

      return puts "Maximum attempts reached." if max_try.zero?
    end
    @@order.update_status(choice)
  end
end
