  require_relative 'drink.rb'
class User < ActiveRecord::Base
  has_many :ratings
  has_many :drinks, through: :ratings
  # attr_reader :last_input
  #
  # def self.welcome
  #   puts "Enter your age:"
  #   input1 = gets.chomp
  #   User.create(age: input1)
  #   if input1.to_i > 20
  #     puts "Welcome to C2H50H - World"
  #      input2 = self.insert_name
  #      Drink.alcohol_or_no
  #   else
  #     puts "Do you want to see our non-alcohol drink?(Y/N)"
  #     input3 = gets.chomp
  #       if input3 == "Y"
  #          self.insert_name
  #       else
  #         puts "Enjoy your life!"
  #         User.all.last.delete
  #       end
  #   end
  # end
  #
  #
  # def self.insert_name
  #   puts "Enter your name:"
  #   input = gets.chomp
  #   User.all.last.update(name: input.to_s)
  # end

    #if the user is already existed, print welcome back, otherwise create new and move on?
    #how do we know the user is alread existed?

    # def self.find_by_name(input)
    #   User.where(:name =>"input").first_or_create do |user|
    #     user.name = user[:name]
    #   name = input.downcase
    # user_name =  User.all.find_by {|user| user.name.downcase == name}
    # if !user_name.nil?
    #     User.all.last.delete
    #     puts "Welcome back #{user_name}"
    #   else
    #       puts "Welcome #{user_name}"
    #   end
    # end




  # private
  # def user_input
  #   @last_input = gets.strip
  # end

end
