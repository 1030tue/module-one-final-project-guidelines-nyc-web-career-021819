require_relative "user.rb"
require 'rest-client'
require 'json'
require 'pry'

class Drink < ActiveRecord::Base
  has_many :ratings
  has_many :users, through: :ratings


  def self.alcohol_or_no
    puts "Would like to have a virgin drink? (Y/N)"
    input = gets.strip
    if input.to_s != "N"
     num = Drink.get_number_from_user
     self.cocktail_list(num)
   end
  end

  def self.get_number_from_user
    self.selection
    input = gets.strip
    input.to_i
    # if input.to_i == 1
    #   response_string = RestClient.get("https://www.thecocktaildb.com/api/json/v1/1/filter.php?i=Amaretto")
    #        response_hash = JSON.parse(response_string)
    #        drinks = response_hash["drinks"]
    #        list = drinks.map {|d| d["strDrink"]}
    #   puts list.sample(5)
    # end
  end

  def self.selection
    puts  "Choose your poison:"
     puts "1. Amaretto"
     puts "2. Bourbon "
     puts "3. Gin "
     puts "4. Tequila "
     puts "5. Vodka"
     puts "6. Scotch "
     puts "7. Wine "
     puts "8. Exit and go back to Main Menu "
   end

   def self.cocktail_list(num)
       if num == 1
         puts "*** Here is your cocktail list ***"
         input = "Amaretto"
         response_string = RestClient.get("https://www.thecocktaildb.com/api/json/v1/1/filter.php?i=#{input}")
              response_hash = JSON.parse(response_string)
              drinks = response_hash["drinks"]
              list = drinks.map {|d| d["strDrink"]}
         puts list.sample(5)
       elsif
         num == 2
         puts "do whatev"
        end
      end

end
