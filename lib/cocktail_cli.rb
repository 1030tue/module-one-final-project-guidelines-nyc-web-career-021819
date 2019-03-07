require_relative 'communication.rb'

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
      valid = false
      until valid
        input = user_input.to_i
        array = (1..120).to_a
        if !array.include?(input)
          puts "<<<<   INVALID!!   >>>>\nHi, #{@name}. Enter your age:"
        else
          valid = true
          @age = input
          get_user
        end
      end
      end

    def get_user
      @save_user = User.find_or_create_by(name: @name , age: @age)
      over_20
    end


    def over_20
      if @age > 20
        menu_over_20
      else
         puts " >>>> You are not legally allowed to consume alcohol <<<<  \n       >>> Come and visit us #{21 - @age} years later. <<<
         \n               >>-  Enjoy your life!  -<< "
       end
    end


    # valid = false
    #   until valid
    #       input1 = user_input.to_i
    #       array = [1,2,3,4,5]
    #   if !array.include?(input1)
    #     puts ">>>> ABORTED! This is not valid. \n>>>> Please try again. >>>>"
    #   else
    #     valid = true
    #   end
    # end
    #  get_drink_info(input1)



    def menu_over_20
    puts ">>>> What would you like to do?"
    puts "1. View cocktail list"
    puts "2. View virigin drinks"
    puts "3. View favorites"
    puts "4. Exit"
    main_menu_loop
  end



  def main_menu_loop
      while user_input != "100"
        case last_input.to_i
        when 1
          selection
          ask_validity([1,2,3,4,5,6,7,8])
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
          puts "<<<<    INVALID!!    >>>>"
          menu_over_20
          break
        end
    end
  end





    def selection
       puts  "***** Base Spirits *****".center(34)
       puts "1. Amaretto"
       puts "2. Bourbon "
       puts "3. Gin "
       puts "4. Tequila "
       puts "5. Vodka"
       puts "6. Scotch "
       puts "7. Wine "
       puts "8. Exit and go back to Main Menu "
       puts  " >>>> Choose your poison:"

    end


    # def cocktail_list(num)
    #   @drink_hash.select do |k,v|
    #     if num = k
    #       get_drink_name(v)
    #       more_info
    #     end
    #   end
    # end


    def cocktail_list(num)
        if num == 1
           get_drink_name("Amaretto")
           more_info
         elsif
         num == 2
          get_drink_name("Bourbon")
          more_info
         elsif
           num == 3
           get_drink_name("Gin")
           more_info
         elsif
           num == 4
           get_drink_name("Tequila")
        more_info
         elsif
           num == 5
           get_drink_name("Vodka")
           more_info
         elsif
           num == 6
           get_drink_name("Scotch")
           more_info
         elsif
           num == 7
           get_drink_name("Wine")
           more_info
         elsif
           num == 8
           puts "Back to Main Menu"
           menu_over_20
      end
   end


     def more_info
       puts ">>>> Pick one for more info:"
       valid = false
         until valid
             input1 = user_input.to_i
             array = [1,2,3,4,5]
         if !array.include?(input1)
           puts " <<<<     INVALID     >>>>  \n>>>> Pick one for more info:"
         else
           valid = true
         end
       end
        get_drink_info(input1)
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
            puts "***** Here is your cocktail list *****"
              drink_hash.each do |k,v|
                  puts  "#{k}. #{v}"
              end
               @drink_hash = drink_hash
    end



    def after_save_favorite
        puts ">>>> What would you like to do next?"
        puts "1. Back To Main "
        puts "2. View Favorites"
        after_save_favorite_options
    end

    def after_save_favorite_options
      while user_input != 100
        case last_input.to_i
        when 1
          menu_over_20
          break
        when 2
        see_favorites
          break
        else
          puts "<<<<    INVALID!!!    >>>>"
          after_save_favorite
        end
      end
    end



    def back_to_main
      puts ">>>> What would you like to do now?"
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
            puts ">>>> Type in the exact drink ID here:"
            input = gets.chomp.to_i
            delete_favorites_by_drink_id(input)
            back_to_main
            break
          when 3
            input_drink_id
            break
          when 4
            exit
            break
          else
            puts "<<<<   INVALID!!   >>>>"
            back_to_main
          end
      end
    end


    def exit
      puts "You've been logged out. \n Enjoy your life. \n Enjoy your drink. \n Drink responsibly. \n *** Come Again!! ***"
      exit!
    end


    def delete_favorites_by_drink_id(input)
      drink = Wish.all.find_by(drink_id: input)
      drink.destroy
      puts "Your rating has been deleted"
    end


#asking drinkID
    def input_drink_id
      valid = false
      until valid
        puts "Type the exact drink ID to leave rating:"
        @drinkid_input = user_input.to_i
        favorite = Wish.all.where(user_id: @save_user)
        f_arr = favorite.map {|f| f.drink_id}
        if !f_arr.include?(@drinkid_input)
          puts "Plase enter a valid drink ID from your favorite list"
        else
          valid = true
        end
      end
      input_rate
    end



    def input_rate
      drink = Wish.all.find_by(drink_id: @drinkid_input)
      puts ">>>> Please rate from 0 to 5:"

        valid = false
        until valid
          if input2 = user_input.to_f
            array = (1..5).to_a
            if !array.include?(input2)
              puts "<<<<     INVALID     >>>> "
              input_rate
            else
              valid = true
            end
          end


      rating = Rating.all.find_by(drink_id: @drinkid_input)
      if rating
        Rating.all.where(user_id: @save_user).where(drink_id: @drinkid_input).update(rating: input2)
      else
          Rating.create(user_id: @save_user, drink_id: @drinkid_input, rating: input2)
        end
      puts "Your rating has been saved"
      puts ">>>> Would you like to leave comment as well?(Y/N)"

      valid = false
        until valid
        array = ["yes", "no", "y", "n"]
        input3 = user_input.to_s.downcase
        if !array.include?(input3)
          puts " <<<<     INVALID     >>>> \n>>>> Would you like to leave comment as well?(Y/N)"

        else
          valid = true
        end
      end
      if input3 == "y"
        leave_comment(@drinkid_input)
      else
        menu_over_20
      end
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
        Rating.all.where(user_id: @save_user).where(drink_id: drink_id).update(comment: comment)
      else
          Rating.create(user_id: @save_user, drink_id: drink_id, comment: comment)
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


      def ask_validity(array)
          valid = false
            until valid
            input1 = user_input.to_i
            if !array.include?(input1)
              puts " <<<<     INVALID     >>>>  \n"
              selection
            else
              valid = true
              cocktail_list(input1)
            end
          end
      end






      # put the prompt
      # save gets.chomp
      # check if valid (valid_inputs_arr.include?(get.chomp))
      # if yes, return that input1
      # if no, loop again





end
