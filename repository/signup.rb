require_relative "dbconnection"

class Signup     
    #def keyword automatically trad as a begin block no need to manually write begin
    def self.sign(username,password,contact,email,type)
      stmt = $db.prepare("INSERT INTO user(uname,pwd,contact,email,type) values(?,?,?,?,?)")
      stmt.execute(username,password,contact,email,type)
      "Succesfully Sign-up"
    rescue => e
    puts "#{e}"
    end
end

