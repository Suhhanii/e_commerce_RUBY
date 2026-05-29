require 'byebug'
class User
  attr_accessor :id,
                :uname,
                :pwd,
                :contact,
                :email,
                :type

  def initialize(data)
    data = data.transform_keys(&:to_sym)
    @id      = data[:id]
    @uname   = data[:uname]
    @pwd     = data[:pwd]
    @contact = data[:contact]
    @email   = data[:email]
    @type    = self.class.to_s
  end

  def admin?
    type == "admin"
  end

  def customer?
    type == "customer"
  end

  def save!
    byebug
    validate!
  end

  def validate!
    if !valid_email? || !valid_contact?
    end
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

  def self.see_all_user
    puts $data['user_menu']
    value = gets.chomp.to_i
    type = LoginSignupService::TYPE[value]
    unless type
      stmt = $db.prepare("select * from user where type = ?")
      data = stmt.execute(type)
    else
      data = $db.query("select * from user")
    end
  rescue => e
    puts "#{e} Error while fetching all users"
  end

  def self.remove_user(id)
    stmt = $db.prepare("delete from user where id = ?")
    stmt.execute(id)
    puts "User Deleted Successfully"
  rescue => e
    puts "#{e} Error while removing user"
  end
end
