


# def get_character_movies_from_api(character_name)
#   #make the web request
#
#   response_string = RestClient.get("http://www.swapi.co/api/people/")
#   response_hash = JSON.parse(response_string)
#
# #user
# u1 = User.create(:name => "Kate", :age => "15")
# u2 = User.create(:name => "Diana", :age => "24")
#
#
# #drinks
# d1 = Drink.create(:name => "Manhattan", :alcohol? => 1, :liquor => "Bourbon")
# d2 = Drink.create(:name => "Appletini", :alcohol? => 1, :liquor => "Gin")
# d3 = Drink.create(:name => "Grapepunch",:alcohol? => 0, :liquor => "N/A")
#
#
# #rating
r1 = Rating.create(user_id: 61 ,drink_id: 12388, rating: 4, comment: "Ehh...")
r2 = Rating.create(user_id: 62 ,drink_id: 12388, rating: 2, comment: "Tasted like a water")
r3 = Rating.create(user_id: 63 ,drink_id: 12388, rating: 5, comment: "Yummy!")


# drink = Wish.all.map {|d| d.drink_name}
# drink.map do |d|
#   response_string= RestClient.get("https://www.thecocktaildb.com/api/json/v1/1/search.php?s=#{d}")
#   response_hash = JSON.parse(response_string)
#   drinks = response_hash["drinks"]
#   drinks.map do |d|
#     binding.pry
#   puts " ID: #{d["idDrink"]}"
#   puts " NAME: #{d["strDrink"]}"
#   puts " INGREDIENTS:"
#   puts "\t #{d["strIngredient1"]}"
#   puts "\t #{d["strIngredient2"]}"
#   puts "\t #{d["strIngredient3"]}"
#
#   puts "*" * 5
# end
# end
