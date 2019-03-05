
#user
u1 = User.create(:name => "Kate", :age => "15")
u2 = User.create(:name => "Diana", :age => "24")


#drinks
d1 = Drink.create(:name => "Manhattan", :alcohol? => 1, :liquor => "Bourbon")
d2 = Drink.create(:name => "Appletini", :alcohol? => 1, :liquor => "Gin")
d3 = Drink.create(:name => "Grapepunch",:alcohol? => 0, :liquor => "N/A")


#rating
r1 = Rating.create(user: u1, drink: d1, rating: 4, comment: "Ehh...")
r2 = Rating.new(user: u2,drink: d2, rating: 2, comment: "Tasted like a water")
r3 = Rating.new(user: u2,drink: d3, rating: 5, comment: "Yummy!")
