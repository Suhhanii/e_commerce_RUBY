require_relative "Service/login_signup_service"
require "io/console"
require "highline"
require "yaml"

$data = YAML.load_file('en.yml');
class CLI
  def self.run
    puts $data['login_signup_menu']
    value = gets.chomp.to_i

    case value
    when 1
      puts "-----------------------"

      puts "Enter Username / Email"
      uname = gets.chomp

      hide = HighLine.new
      pwd = hide.ask("Enter Password") { |r| r.echo = "*"}

      puts "-----------------------"

      LoginSignupService.log_in(uname, pwd)
    when 2
      puts "-----------------------"

      puts "Enter Username"
      uname = gets.chomp

      hide = HighLine.new
      pwd = hide.ask("Enter Password") { |r| r.echo = "*"}

      puts "Enter Contact"
      contact = gets.chomp.to_i
      until contact.digit.count != 10
        puts "Enter Contact"
        contact = gets.chomp.to_i
      end

      puts "Enter Email"
      email = gets.chomp
      until email.end_with?("@gmail.com")
         puts "Enter Valid email"
         email = gets.chomp
      end

      puts $data['sign_up_user_menu']
      type = gets.chomp.to_i
      if [1, 2].include?(type)
        LoginSignupService.signup(uname, pwd, contact, email, type)
      else
        puts "Select Valid Type"
        self.run
      end
    when 3
      exit
    else
      puts "Wrong Choice Please Try Again"
      run
    end
  end
end

CLI.run
