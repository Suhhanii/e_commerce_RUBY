require_relative '../Service/admin_service'
require_relative '../Service/user_service'
class Home
  def self.home
    loop do
      puts "-----------------------"
      puts "1) For Get Category"
      puts "2) For Get All Products"
      puts "3) For Get Product By Category"
      puts "4) For Open Cart"
      puts "5) For Add Product into Cart"
      puts "6) For Remove Product From Cart"
      puts "7) For Checkout"
      puts "8) For Exit"
      puts "-----------------------"

      value = gets.chomp.to_i

      case value
      when 1
        data = User.get_category
        data.each do |val|
            puts "-----------------------"
            puts "Id: #{val["id"]}"
            puts "Category: #{val["name"]}"
            puts "-----------------------"
        end
      when 2
        data = User.get_all_products
        data.each do |val|
            puts "-----------------------"
            puts "Id: #{val["id"]}"
            puts "Name: #{val["name"]}"
            puts "Category: #{val["category"]}"
            puts "Price: #{val["price"]}"
            puts "Stock: #{val["stock"]}"
            puts "-----------------------"
        end
      when 3 
        puts "Enter Category"
        category = gets.chomp
        data = User.get_product_by_category(category)
        data.each do |val|
            puts "-----------------------"
            puts "Id: #{val["id"]}"
            puts "Name: #{val["name"]}"
            puts "Category: #{val["category"]}"
            puts "Price: #{val["price"]}"
            puts "Stock: #{val["stock"]}"
            puts "-----------------------"
        end
      when 8
        break;
      else
        puts "Wrong Choice Please Try Again"
      end
    end
  end

  


  def self.admin
   loop do
      puts "-----------------------"
      puts "1) For Add New Category"
      puts "2) For Add New Product"
      puts "3) For See All User"
      puts "4) For See All Admins"
      puts "5) For Remove Any User"
      puts "6) For Remove Any Product"
      puts "7) For Exit"
      puts "-----------------------"

      value = gets.chomp.to_i

     case value
      when 1
        puts "-----------------------"
        puts "Enter new Category Name"
        name = gets.chomp
        puts Admin.add_category(name)
        puts "-----------------------"
      when 2
        puts "-----------------------"
        puts "Enter Name Of Product"
        name = gets.chomp
        puts "Enter Category Of Product"
        category = gets.chomp
        puts "Enter price Of Product"
        price = gets.chomp
        puts "Enter Quantity Of Product"
        stock = gets.chomp
        puts "-----------------------"
        Admin.add_product(name,category,price,stock)
      when 3
        puts "-----------------------"
        data = Admin.see_all_user;
          data.each do |val|
            puts "-----------------------"
            puts "Id: #{val["id"]}"
            puts "Name: #{val["uname"]}"
            puts "Password: #{val["pwd"]}"
            puts "Contact: #{val["contact"]}"
            puts "Email: #{val["email"]}"
            puts "Type: #{val["type"]}"
            puts "-----------------------"
          end
      when 4
        data = Admin.see_only_admin
          data.each do |val|
            puts "-----------------------"
            puts "Id: #{val["id"]}"
            puts "Name: #{val["uname"]}"
            puts "Password: #{val["pwd"]}"
            puts "Contact: #{val["contact"]}"
            puts "Email: #{val["email"]}"
            puts "Type: #{val["type"]}"
            puts "-----------------------"
          end
      when 5
        puts "Enter User id"
        id = gets.chomp.to_i
        puts "Enter User Name"
        name = gets.chomp
        puts Admin.remove_user(id,name)
      when 6
        puts "Enter Product Id"
        id = gets.chomp.to_i
        puts "Enter Product Name"
        name = gets.chomp
        puts Admin.remove_user(id,name)
      when 7
        break;
      else
        puts "Wrong Choice Please Try Again"
     end
    end
  end
end


