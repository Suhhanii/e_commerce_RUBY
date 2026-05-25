
class Dbconnection

  def self.connect 
    db = Mysql2::Client.new(
      host: "localhost",
      username: "rails",
      password: "Rails@12345",
      database: "rubywork"
    )
  end  
end
