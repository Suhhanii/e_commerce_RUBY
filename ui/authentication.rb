require_relative '../Service/login_signup_service'

class Authentication
  def self.run
    puts "Log-in / Sign-up"

    puts "-----------------------"
    puts "1) For Log-in"
    puts "2) For Sign-up"
    puts "3) For Exit"
    puts "-----------------------"
    value = gets.chomp.to_i

    case value
    when 1
      puts "-----------------------"
      puts "Enter Username"
      uname = gets.chomp
      puts "Enter Password"
      pwd = gets.chomp
      puts "-----------------------"
      puts LoginSignupService.log(uname,pwd)
    when 2
      puts "-----------------------"
      puts "Enter Username"
      uname = gets.chomp
      puts "Enter Password"
      pwd = gets.chomp
      puts 'Enter Contact'
      contact = gets.chomp.to_i
      puts "Enter Email"
      email = gets.chomp
      puts "Enter Type of User"
      type = gets.chomp.downcase
      puts "-----------------------"
      puts LoginSignupService.signup(uname,pwd,contact,email,type)
    when 3
      exit
    else
      puts "Wrong Choice Please Try Again"
    end
  end
end

Authentication.run