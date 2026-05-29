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
      pwd = hide_password

      puts "-----------------------"

      LoginSignupService.log_in(uname, pwd)
    when 2
      puts "-----------------------"

      puts "Enter Username"
      uname = gets.chomp
      pwd = hide_password

      puts "Enter Contact"
      contact = gets.chomp.to_i

      puts "Enter Email"
      email = gets.chomp

      puts $data['sign_up_user_menu']
      type = gets.chomp.to_i
      data = {uname: uname, pwd: pwd, contact: contact, email: email, type: type}
      User.new(data).save!
      # LoginSignupService.signup(uname, pwd, contact, email, type)
    when 3
      exit
    else
      puts "Wrong Choice Please Try Again"
      run
    end
  end

  def self.hide_password
    hide = HighLine.new
    hide.ask("Enter Password") { |r| r.echo = "*"}
  end
end

CLI.run
