require_relative "Service/login_signup_service"
require "io/console"
require "highline"

class CLI
  def self.run
    puts <<~DATA
           Log-in / Sign-up
           -----------------------
           1) For Log-in
           2) For Sign-up
           3) For Exit
           -----------------------
         DATA
    value = gets.chomp.to_i

    case value
    when 1
      puts "-----------------------"

      puts "Enter Username"
      uname = gets.chomp

      hide = HighLine.new
      pwd = hide.ask("Enter Password") { |r| r.echo = "*"}

      puts "-----------------------"

      LoginSignupService.log_in(uname, pwd)
    when 2
      puts "-----------------------"

      puts "Enter Username"
      uname = gets.chomp

      puts "Enter Password"
      hide = HighLine.new
      pwd = hide.ask("Enter Password") { |r| r.echo = "*"}

      puts "Enter Contact"
      contact = gets.chomp.to_i
      catch (:rerun) do
        contact = gets.chomp.to_i
        if contact.digits.length>10 || contact.digits.length<10
          puts "Contact Number should be 10 digits Only"
          throw :rerun
        end
      end

      puts "Enter Email"
      email = gets.chomp
      catch (:rerun) do
        email = gets.chomp
        unless email.end_with?("@gmail.com")
          throw :rerun
        end
      end

      puts <<~INPUT
             Select Which Type Of User You Are
             1) For Admin
             2) For Customer
           INPUT

      puts "-----------------------"
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
    end
    run
  end
end

CLI.run
