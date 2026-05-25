require_relative 'dbconnection'
class Cart

  def self.add_to_cart
    $db = Dbconnection.connect
  end
      
end