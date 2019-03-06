
class CLI


  def welcome
    puts "Hey! Welcome to our app!!"
    get_name

  end

  def get_name
    puts "Enter your name:"
    @name = gets.chomp
    get_age
  end


  def get_age
    puts "Enter your age:"
    @age = gets.chomp.to_i
    get_user
  end

  def get_user
    User.find_or_create_by(name: @name , age: @age)
    over_20
  end


  def over_20
    if @age > 20
      Drink.alcohol_or_no
    else
       puts "Do you want to see our non-alcohol drink?(Y/N)"
        ans = gets.chomp
        if ans.downcase == "y"
          puts "we should put non alcoholic list "
        else
          puts "Enjoy your life!"
        end
     end
  end

end
