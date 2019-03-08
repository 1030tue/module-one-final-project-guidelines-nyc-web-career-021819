require_relative 'communication.rb'
require_relative 'colorize.rb'

class String
  BLANK_RE = /\A[[:space:]]*\z/
def blank?
  empty? || BLANK_RE.match?(self)
 end
end



class CLI < String
attr_reader :last_input

    def welcome
      puts "Hey! Welcome to C2H50H WORLD!!".black.bold.swap
      @pid = fork{ exec 'afplay', "lib/Autumn Leaves Chet Baker - Paul Desmond.mp3" }
      get_name
    end

    system "clear"



    def get_name
      valid = false
      until valid
          puts "Enter your name:"
            name = gets.chomp
        if name.blank? == true || name.to_s.length < 2
          puts "<<<<  INVALID!!  >>>>".red.bold
        else
          valid = true
          @name = name
        end
      end
          get_age
    end



    def get_age
      promt = "Hi, #{@name}. Enter your age:"
          valid(promt, (1..120).to_a)
          system "clear"
          get_user
      end



    def get_user
      @save_user = User.find_or_create_by(name: @name , age: @input)
      over_20
    end


    def over_20
      if @input > 20
        menu_over_20
      else
         Process.kill("SIGKILL", @pid)
         puts "\n\n >>>> You are not legally allowed to consume alcohol. <<<<  \n       >>> Come and visit us #{21 - @input} years later. <<<
         \n              >>- ❤ Enjoy your life! ❤ -<< ".bold
       end
    end


      def menu_over_20
          puts ">>>> What would you like to do?"
          puts "1. View cocktail list"
          puts "2. View virigin drinks"
          puts "3. Find cocktail by name"
          puts "4. View your Favorites"
          puts "5. Exit"
          main_menu_loop
          system "clear"
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
              cocktail_find_by_name
              break
            when 4
              see_favorites
              break
            when 5
              exit
              break
            else
              puts "<<<<    INVALID!!    >>>>".red.bold
              menu_over_20
              break
            end
        end
      end


      def spirits_hash
        {1 => "Amaretto", 2 => "Bourbon", 3 => "Gin", 4 => "Tequila", 5 => "Vodka", 6 => "Scotch", 7 => "Wine"}
      end


      def selection
          system "clear"
           puts  "***** Base Spirits *****".center(34)
         spirits_hash.each do |k,v|
           puts  "#{k}. #{v}"
         end
         puts "8. Exit and go back to Main Menu "
         puts  " >>>> Choose your poison:".bold
      end



        def cocktail_list(num)
            spirits_hash.select do |k,v|
            if num < 8
              s_has = spirits_hash.select {|k,v| k == num}
              s_name = s_has.values.join()
              get_drink_name(s_name)
              more_info
            elsif num == 8
              puts "Back to Main Menu"
              menu_over_20
           end
          end
        end



     def more_info
       prompt = ">>>> Pick one for more info:".bold
       valid(prompt, [1,2,3,4,5])
       get_drink_info(@input)
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
              system "clear"
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
          puts "<<<<    INVALID!!!    >>>>".red.bold
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
system "clear"
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
            puts "<<<<   INVALID!!   >>>>".red
            back_to_main
          end
      end
    end


    def exit
      system "clear"

      Process.kill("SIGKILL", @pid)

      puts "You've been logged out. \n Enjoy your life. \n Enjoy your drink. \n Drink responsibly. \n *** Come Again!! ***".bold.blink
      exit!

    end


    def delete_favorites_by_drink_id(input)
      drink = Wish.all.where(user_id:@save_user.id).find_by(drink_id: input.to_i)
      puts "\"#{input}\" has been deleted from your favorites."
      drink.destroy
    end



    def input_drink_id
      valid = false
      until valid
        puts "Type the exact drink ID to leave rating:"
        @drinkid_input = user_input.to_i
        favorite = Wish.all.where(user_id: @save_user.id)
        f_arr = favorite.map {|f| f.drink_id}
        if !f_arr.include?(@drinkid_input)
          puts "Plase enter a valid drink ID from your favorite list"
        else
          valid = true
        end
      end
      input_rate
    end

    def number?(obj)
      obj = obj.to_s unless obj.is_a? String
      /\A[+-]?\d+(\.[\d]+)?\z/.match(obj)
    end

    def input_rate
      drink = Wish.all.find_by(drink_id: @drinkid_input)
      puts ">>>> Please rate from 0 to 5:".bold
        valid = false
        until valid
            input2 = user_input
            if !number?(input2)
              puts "<<<<     INVALID     >>>> ".red
              input_rate
             elsif input2.to_f > 5 || input2.to_f < 0
                puts "<<<<     INVALID     >>>> ".red
                input_rate
                else
                  valid = true
                  @input2 = input2.to_f
              end

        end
           rating = Rating.all.find_by(drink_id: @drinkid_input)
        if rating
            Rating.all.where(drink_id: @drinkid_input).update(rating: @input2)
        else
            Rating.create(user_id: @save_user.id, drink_id: @drinkid_input, rating: @input2.to_f)
          end
        puts "Your rating has been saved"
        prompt = ">>>> Would you like to leave comment as well?(Y/N)"
        valid_yes_or_no(prompt, ["yes", "no", "y", "n"])
        if @input == "y" || @input == "yes"
          leave_comment(@drinkid_input)
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
        # puts "Enter your comment. (limit 50 char)"
        # @comment = user_input.to_s
     valid = false
     until valid
       puts "Enter your comment. (limit 50 char)"
       comment = user_input
        if comment.blank?
           puts "The comment cannot be blank.".bold
         elsif comment.length > 50
           puts "The comment should be less than 50 charaters.".bold
         else
           valid = true
           @comment = comment.to_s
         end
       end
     rating = Rating.all.find_by(drink_id: drink_id)
     if rating
       rating.update(comment: @comment)
     else
         Rating.create(user_id: @save_user.id, drink_id: drink_id, comment: @comment)
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




      def ask_validity(array)
          valid = false
            until valid
            input1 = user_input.to_i
            if !array.include?(input1)
              puts " <<<<     INVALID     >>>>  \n".red.bold
              selection
            else
              valid = true
              cocktail_list(input1)
            end
          end
      end



      def valid(prompt, array)
        valid = false
        until valid
          puts prompt
          input = user_input.to_i
          if !array.include?(input)
            puts "<<<<   INVALID!!   >>>>".red.bold
          else
            valid = true
            @input = input
          end
        end
      end




end
