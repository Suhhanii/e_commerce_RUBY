require_relative "../dbconnection"
#  require_relative '../ui/home'
require_relative "../models/user"
require_relative "../models/customer_user"
require_relative "../models/admin_user"
require "byebug"

class LoginSignupService
  TYPE = { 1 => "admin", 2 => "customer" }

  def self.log_in(username, password)
    stmt = $db.prepare("SELECT * FROM user WHERE uname = ? AND pwd = ?")
    result = stmt.execute(username, password)&.first
    #safe navigation operator & , call first when result is not nil
    #if we dont use it an datanot get from database it will raise an error

    if result.nil?
      puts "Incorrect Username or Password"
      return
    end

    $current_user = User.new(result)

    if $current_user.admin?
      puts "Login Successfully"
      AdminUser.home
    else
      puts "Login Successfully"
      CustomerUser.home
    end
  rescue => e
    return "Database Error: #{e.message}"
  end

  def self.signup(username, password, contact, email, type)
    user = TYPE[type]
    stmt = $db.prepare("INSERT INTO user(uname,pwd,contact,email,type) VALUES(?,?,?,?,?)")
    stmt.execute(username, password, contact, email, user)

    stmt = $db.prepare("SELECT * FROM user WHERE uname = ? AND pwd = ?")
    result = stmt.execute(username, password)&.first

    if result.nil?
      puts "Not Able to Sign Up Try Again"
      CLI.run
    end

    $current_user = User.new(result)

    if $current_user.admin?
      puts  "Sign Up Successfully"
      AdminUser.home
    else
      puts  "Sign Up Successfully"
      CustomerUser.home
    end
  rescue => e
    puts "#{e.message}"
  end
end
