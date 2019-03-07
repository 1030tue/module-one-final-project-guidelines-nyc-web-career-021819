
class CLI
attr_reader :last_input

    def welcome
      puts "Hey! Welcome to C2H50H WORLD!!"
      get_name

    end

    def get_name
      puts "Enter your name:"
      @name = gets.chomp
      get_age
    end


    def get_age
      puts "Hi, #{@name}. Enter your age:"
      @age = gets.chomp.to_i
      get_user
    end

    def get_user
      @save_user = User.find_or_create_by(name: @name , age: @age)
      binding.pry
      over_20
    end


    def over_20
      if @age > 20
        menu_over_20
      else
         puts " >> You are not legally allowed to consume alcohol << . \n Come and visit us #{21 - @age} years later. \n >>Enjoy your life! << "
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
      while user_input != "5"
        case last_input.to_i
        when 1
          alcohol_or_no
          break
        when 2
          non_alcoholic_selection
          break
        when 3
          see_favorites
          break
        when 4
          exit
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


    def alcohol_or_no
      # puts "Would you like to grap a glass of cocktail? (Y/N)"
      # input = gets.chomp
      # if input.to_s.downcase == "y"
        selection
        cocktail_list(user_input.to_i)
      # else
      #   puts "!!!! Non Alcoholic Drink List"

    end

    # def get_number_from_user
    #   input = gets.strip
    #   input.to_i
    # end


    def selection
       puts  " >>> Choose your poison:"
       puts "1. Amaretto"
       puts "2. Bourbon "
       puts "3. Gin "
       puts "4. Tequila "
       puts "5. Vodka"
       puts "6. Scotch "
       puts "7. Wine "
       puts "8. Exit and go back to Main Menu "
    end


    def non_alcoholic_selection
      url = "https://www.thecocktaildb.com/api/json/v1/1/filter.php?a=Non_Alcoholic"
            response_string= RestClient.get(url)
            response_hash = JSON.parse(response_string)
            drinks = response_hash["drinks"]
            na_list = drinks.map {|d| d["strDrink"]}
           na_list5 = na_list.sample(5)
            drink_hash = {}
              n = 1
              na_list5.map do |d|
              drink_hash[n] = d
              n+=1
              end
              puts "*** Here is your non alcoholic drink list ***"
                drink_hash.each do |k,v|
                    puts  "#{k}. #{v}"
                end
                 @drink_hash = drink_hash
                 puts "Pick one for more info:"
                 get_drink_info(user_input.to_i)
    end



    def cocktail_list(num)
        if num == 1
           get_drink_name("Amaretto")
           puts "Pick one for more info:"
           get_drink_info(user_input.to_i)
         elsif
         num == 2
         get_drink_name("Bourbon")
         puts "Pick one for more info:"
         get_drink_info(user_input.to_i)
         elsif
           num == 3
           get_drink_name("Gin")
           puts "Pick one for more info:"
           get_drink_info(user_input.to_i)
         elsif
           num == 4
           get_drink_name("Tequila")
           puts "Pick one for more info:"
           get_drink_info(user_input.to_i)
         elsif
           num == 5
           get_drink_name("Vodka")
           puts "Pick one for more info:"
           get_drink_info(user_input.to_i)
         elsif
           num == 6
           get_drink_name("Scotch")
           puts "Pick one for more info:"
           get_drink_info(user_input.to_i)
         elsif
           num == 7
           get_drink_name("Wine")
           puts "Pick one for more info:"
           get_drink_info(user_input.to_i)
         elsif
           num == 8
           puts "Back to Main Menu"
      end
   end

    def get_drink_name(input)
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
            puts ">>>> Here is your cocktail list <<<<"
              drink_hash.each do |k,v|
                  puts  "#{k}. #{v}"
              end
               @drink_hash = drink_hash
    end


    def get_drink_info(num)
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
              puts " KEY INGREDIENTS:"
              puts "\t #{d["strIngredient1"]}"
              puts "\t #{d["strIngredient2"]}"
              puts "\t #{d["strIngredient3"]}"
              display_rate(d["idDrink"].to_i)

              puts "Do you want to add to your favorites? Y/N"
              if user_input.to_s.downcase == "y"
                Wish.create(user_id: @save_user.id, drink_id: drink_id, drink_name: drink_name)
              end
            end
          end
        end
        after_save_favorite
    end

    def after_save_favorite
      puts "What would you like to do next?"
      puts "1. Back To Main "
      puts "2. View Favorites"
       after_save_favorite_options
    end

    def after_save_favorite_options
      while user_input != 3
        case last_input.to_i
        when 1
          menu_over_20
          break
        when 2
        see_favorites
          break
        end
      end
    end


    def see_favorites
      favorite = Wish.all.where(user_id: @save_user.id)
      f_arr = favorite.map {|f| f.drink_name}
      if f_arr.length == 0
        puts "Oh, no! You have no favorites yet!"
        menu_over_20
      else
      f_arr.each do |n|
      # d_name = favorite.drink_name
      response_string= RestClient.get("https://www.thecocktaildb.com/api/json/v1/1/search.php?s=#{n}")
      response_hash = JSON.parse(response_string)
      drinks = response_hash["drinks"]
      drinks.map do |d|
      puts " ID: #{d["idDrink"]}"
      puts " NAME: #{d["strDrink"]}"
      puts " INGREDIENTS:"
      puts "\t #{d["strIngredient1"]}"
      puts "\t #{d["strIngredient2"]}"
      puts "\t #{d["strIngredient3"]}"
      display_rate(d["idDrink"].to_i)
      display_comment(d["idDrink"].to_i)
      puts "*" * 5
    end
    end
    end
    back_to_main
    end

    def back_to_main
      puts "What would you like to do now?"
      puts "1. Back To Main"
      puts "2. Delete your favorite drink"
      puts "3. Leave a rating for your drink"
      puts "4. Exit"
      menu_options
    end

    def menu_options
        while user_input != 4
          case last_input.to_i
          when 1
            menu_over_20
            break
          when 2
            puts "Type in the exact drink ID here:"
            input = gets.chomp.to_i
            delete_favorites_by_drink_id(input)
            back_to_main
            break
          when 3
            input_rate
            break
          when 4
            exit
            break
          end
      end
    end


    def exit
      puts "You've been logged out. \n Enjoy your life. \n Enjoy your drink. \n Drink responsibly. \n *** Come Again!! ***"
    end


    def delete_favorites_by_drink_id(input)
      drink = Wish.all.find_by(drink_id: input)
      drink.destroy
      puts "Your rating has been deleted"
    end



    def input_rate

      valid = false

      until valid
        puts "Type the exact drink ID to leave rating:"
        input1 = user_input.to_i
        favorite = Wish.all.where(user_id: @save_user.id)
        f_arr = favorite.map {|f| f.drink_id}
        if !f_arr.include?(input1)
          puts "Plase enter a valid drink ID from your favorite list"
        else
          valid = true
        end
      end



      drink = Wish.all.find_by(drink_id: input1)
      puts "Please rate from 0 to 5:"
      input2 = user_input.to_f
      rating = Rating.all.find_by(drink_id: input1)
      if rating
        Rating.all.where(user_id: @save_user.id).where(drink_id: input1).update(rating: input2)
      else
          Rating.create(user_id: @save_user.id, drink_id: input1, rating: input2)
        end
      puts "Your rating has been saved"
      puts "Would you like to leave comment as well?(Y/N)"
      if user_input.to_s.downcase == "y"
        leave_comment(input1)
      else
        menu_over_20
      end
    end


    def display_rate(drink_id)
      arr = Rating.all.where(drink_id: drink_id).map {|d| d.rating}
      if arr.length == 0
        puts " AVG RATING: No rating exists"
      else
      avr = arr.sum/arr.length
      puts  " AVG RATING: #{avr.round(2)}"
    end
    end


    def leave_comment(drink_id)
      puts "Enter your comment. (limit 100 char)"
      comment = user_input.to_s
      rating = Rating.all.find_by(drink_id: drink_id)
      if rating
        Rating.all.where(user_id: @save_user.id).where(drink_id: drink_id).update(comment: comment)
      else
          Rating.create(user_id: @save_user.id, drink_id: drink_id, comment: comment)
        end
        puts "Your comment has been saved"
        menu_over_20
    end

    def display_comment(drink_id)
      arr = Rating.all.where(drink_id: drink_id).map {|d| d.comment}
      if arr.length == 0
        puts "*** Be the first one to leave a comment!! ***"
      else
        puts " COMMENT FROM LAST DRINKER: \"#{arr.last}\" "
      end
    end




    private
       def user_input
        @last_input = gets.strip
      end


      #y/n input
      def yes_or_no_input
        if user_input.downcase != "y" || user_input.downcase != "n"
          puts "Please enter \'y\' or \'n\'."
          yes_or_no_input
        end
      end


      def ask_yes_or_no(q = "Please enter \'y\' or \'n\'.", arr = [Y, N])
        valid = false
          until valid
              puts q
              user_input
              if arr.include?(user_input)
                valid = true
              end
          end
        end



      #whole number input
      def integer_input
        if user_input.integer?
          user_input
        else
          put "this is not a valid option"
          user_input
        end
      end



#############IAN's Comment!!!! #################
      # prompt the user for some input
      # check if the input is validates
      # if it is, retun the input1
      # otherwise, keep asking!
      def ask(prompt, valid_inputs_arr)
        # put the prompt
        # save gets.chomp
        # check if valid (valid_inputs_arr.include?(get.chomp))
        # if yes, return that input1
        # if no, loop again
      end

      # put the prompt
      # save gets.chomp
      # check if valid (valid_inputs_arr.include?(get.chomp))
      # if yes, return that input1
      # if no, loop again





end
