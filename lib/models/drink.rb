require_relative "user.rb"
require 'rest-client'
require 'json'
require 'pry'

class Drink < ActiveRecord::Base
  has_many :ratings
  has_many :users, through: :ratings

attr_accessor :drink_hash

  def self.alcohol_or_no
    # puts "Would like to have a virgin drink? (Y/N)"
    # input = gets.strip
    # if input.to_s.downcase == "n"
      self.selection
      num = Drink.get_number_from_user
      self.cocktail_list(num)
   # end
  end

  def self.get_number_from_user
    input = gets.strip
    input.to_i
  end

  def self.selection
    puts  "Choose your poison:"
     puts "1. Amaretto"
     puts "2. Bourbon"
     puts "3. Gin"
     puts "4. Tequila"
     puts "5. Vodka"
     puts "6. Scotch"
     puts "7. Wine"
     puts "8. Exit"
   end

   def self.cocktail_list(num)
     puts "*** Here is your cocktail list ***"
       if num == 1
         self.get_drink_name("Amaretto")
         puts "Pick one for more info:"
         self.get_drink_info(self.user_input.to_i)
       elsif
         num == 2
         self.get_drink_name("Bourbon")
         puts "Pick one for more info:"
         self.get_drink_info(self.user_input.to_i)
       elsif
         num == 3
         self.get_drink_name("Gin")
         puts "Pick one for more info:"
         self.get_drink_info(self.user_input.to_i)
       elsif
         num == 4
         self.get_drink_name("Tequila")
         puts "Pick one for more info:"
         self.get_drink_info(self.user_input.to_i)
       elsif
         num == 5
         self.get_drink_name("Vodka")
         puts "Pick one for more info:"
         self.get_drink_info(self.user_input.to_i)
       elsif
         num == 6
         self.get_drink_name("Scotch")
         puts "Pick one for more info:"
         self.get_drink_info(self.user_input.to_i)
       elsif
         num == 7
         self.get_drink_name("Wine")
         puts "Pick one for more info:"
         self.get_drink_info(self.user_input.to_i)
       elsif
         num == 8
         puts "Back to Main Menu"
        end
      end

    def self.get_drink_name(input)
      response_string = RestClient.get("https://www.thecocktaildb.com/api/json/v1/1/filter.php?i=#{input}")
           response_hash = JSON.parse(response_string)
           drinks = response_hash["drinks"]
           list = drinks.map {|d| d["strDrink"]}
           list5 = list.sample(5)
           drink_hash = {}
           n = 1
           list5.map do |d|
             drink_hash[n] = d
             n+=1
           end
           drink_hash.each do |k,v|
              puts  "#{k}. #{v}"
           end
           @drink_hash = drink_hash
    end


    def self.user_input
      # puts "Pick one for more info:"
      input = gets.chomp
      input
    end


    def self.get_drink_info(num)
      @drink_hash.each do |k,v|
        if num == k
          response_string= RestClient.get("https://www.thecocktaildb.com/api/json/v1/1/search.php?s=#{v}")
          response_hash = JSON.parse(response_string)
          drinks = response_hash["drinks"]
          drinks.map do |d|
            drink_id = d["idDrink"]
            drink_name = d["strDrink"]

          puts " ID: #{d["idDrink"]}"
          puts " NAME: #{d["strDrink"]}"
          puts " INGREDIENTS:"
          puts "\t #{d["strIngredient1"]}"
          puts "\t #{d["strIngredient2"]}"
          puts "\t #{d["strIngredient3"]}"


          puts "Do you want to add to your favorites? Y/N"
          input = self.user_input
          if input.to_s.downcase == "y"
            Wish.create(user_id: User.all.last.id, drink_id: drink_id, drink_name: drink_name)
          end


        end
      end
    end
    end





end
