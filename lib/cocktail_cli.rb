
class CLI
  attr_reader :last_input


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
      menu_over_20
      # Drink.alcohol_or_no
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

  def menu_over_20
    puts "What would you like to do?"
    puts "1. View cocktail list"
    puts "2. View virigin drinks"
    puts "3. View favorites"
    puts "4. Exit"
    main_menu_loop
  end

  def main_menu_loop
    while user_input != "4"
      case last_input.to_i
      when 1
        Drink.alcohol_or_no
        break
      when 2
        puts "list of non-alco drinks"
        break
      when 3
        puts "view favorites"
        break
      else
        menu_over_20
        break
      end
    end
  end


  def menu_under_20
    puts "What would you like to do? "
    puts "1. View virgin drinks"
    puts "2. View your favorites"
    puts "3. Exit"
  end


private

  def user_input
    @last_input = gets.strip
  end


end
