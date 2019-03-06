class Wish < ActiveRecord::Base
  belongs_to :user
  belongs_to :drink



    def self.see_favorites
      drink = Wish.all.map {|d| d.drink_name}
      drink.map do |d|
        response_string= RestClient.get("https://www.thecocktaildb.com/api/json/v1/1/search.php?s=#{d}")
        response_hash = JSON.parse(response_string)
        drinks = response_hash["drinks"]
        drinks.map do |d|
        puts " ID: #{d["idDrink"]}"
        puts " NAME: #{d["strDrink"]}"
        puts " INGREDIENTS:"
        puts "\t #{d["strIngredient1"]}"
        puts "\t #{d["strIngredient2"]}"
        puts "\t #{d["strIngredient3"]}"

        puts "*" * 5
      end
    end
    end


    def self.delete_favorites


    end




end
