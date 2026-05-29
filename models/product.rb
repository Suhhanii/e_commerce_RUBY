require "tabulo"

class Product
  def self.add_product(name, category, price, stock)
    stmt = $db.prepare("insert into product(name,category_id,price,stock) values(?,?,?,?)")
    stmt.execute(name, category, price, stock)
    puts "Product Added Successfully"
  rescue => e
    puts "Please Enter Existing Category, Else Add New Category"
  end

  def self.get_all_products
    data = $db.query("SELECT p.*, c.name AS category_name
                    FROM product p
                    LEFT JOIN category c ON p.category_id = c.id")
  rescue => e
    puts "#{e} error while getting products"
  end

  def self.delete_product(id)
    stmt = $db.prepare("delete from product where id = ?")
    stmt.execute(id)

    puts "Product Deleted Successfully"
  rescue => e
    puts "#{e} Error while deleting product"
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


end
