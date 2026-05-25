require_relative '../repository/login'
require_relative '../repository/signup'

class LoginSignupService
  
  def self.log(username,password)
    Login.log(username,password)
  end

  def self.signup(username,password,contact,email,type)
    Signup.sign(username,password,contact,email,type)
  end
end


