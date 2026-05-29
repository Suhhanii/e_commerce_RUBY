require "tabulo"
require_relative '../dbconnection'

class Category

  def self.show_category(data)
    table = Tabulo::Table.new(data) do |t|
      t.add_column("ID") { |row| "#{row["id"]}"}
      t.add_column("Category") { |row| "#{row["name"]}"}
    end
    puts table
  end

  def self.get_category
    data = $db.query("select * from category")
    return data
  rescue => e
    puts "#{e} error while get category"
  end

  def self.add_category(name)
    stmt = $db.prepare("insert into category(name) values(?)")
    stmt.execute(name)
    puts "Added Successfully"
  rescue => e
    puts "#{e} at Admin Repo"
  end
end

