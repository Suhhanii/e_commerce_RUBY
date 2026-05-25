require "mysql2"
require_relative 'dbconnection'
require_relative '../ui/home'

$current_user = 0

class Login
  def self.log(username, password)
    $types = %w[user admin]
    
    stmt = $db.prepare("SELECT * FROM user WHERE uname = ? AND pwd = ?")
    results = stmt.execute(username, password)
    
    data = ''
    results.each do |row|
        data = row["type"]
        $current_user = row["id"]
    end
    
    if results.count == 0
      "NOT VALID USER, PLEASE SIGN-UP FIRST"
    else
      if $types.include?(data)
        if data == 'user'
          Home.home()
        else
          Home.admin()
        end
      end
    end

  rescue => e
    return "Database Error: #{e.message}"
  end
end
