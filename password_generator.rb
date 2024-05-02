#Securerandom library was used https://github.com/ruby/securerandom
require 'securerandom'

# The PasswordGenerator class is responsible for generating passwords securely.
class PasswordGenerator
  # The generate method generates a secure password of specified length.
  def self.generate(length)
    if length < 4
      raise ArgumentError, "Password length must be at least least 4 and must not contain letters."
    end

    password = SecureRandom.alphanumeric(length)
    password[0] = ('A'..'Z').to_a.sample
    password[1] = ('a'..'z').to_a.sample
    password[2] = (0..9).to_a.sample.to_s
    password[3] = "!@#$%^&*_=+-/€.?<>)".split("").sample

    return password.split('').shuffle.join
  end
end

# The UserInterface class handles interaction with the user.
class UserInterface
  # The get_password_length method gets the password length from the user.
  def self.get_password_length
    print "Please enter a password length: "
    length = gets.chomp.to_i

    return length
  end

  # The print_password method prints the generated password to the screen.
  def self.print_password(password)
    puts "Your password: #{password}"
  end
end

# The Main class contains the main logic of the application.
class Main
  def self.run
    length = UserInterface.get_password_length

    begin
      password = PasswordGenerator.generate(length)
      UserInterface.print_password(password)
    rescue ArgumentError => e
      puts e.message
    rescue => e
      puts "An error occurred: #{e.message}"
    end
  end
end

Main.run
