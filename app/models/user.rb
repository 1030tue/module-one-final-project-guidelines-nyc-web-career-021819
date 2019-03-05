  require_relative 'drink.rb'
class User < ActiveRecord::Base
  has_many :ratings
  has_many :drinks, through: :ratings
  attr_reader :last_input

  def self.welcome
    puts "Enter your age:"
    input1 = gets.chomp
    User.create(age: input1)
    if input1.to_i > 20
      puts "Welcome to C2H50H - World"
       self.insert_name
       Drink.alcohol_or_no

    else
      puts "Do you want to see our non-alcohol drink?(Y/N)"
      input2 = gets.chomp
        if input2 == "Y"
           self.insert_name
        else
          puts "Enjoy your life!"
          User.all.last.delete
        end
    end
  end


  def self.insert_name
    puts "Enter your name:"
    input = gets.chomp
    User.all.last.update(name: input.to_s)
    #Update Userinfo
  end




  # private
  # def user_input
  #   @last_input = gets.strip
  # end

end
