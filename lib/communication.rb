require_relative 'cocktail_cli.rb'

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
              system "clear"
              puts "*** Here is your non alcoholic drink list ***"
                drink_hash.each do |k,v|
                    puts  "#{k}. #{v}"
                end
                 @drink_hash = drink_hash
                 puts "Pick one for more info:"
                 valid = false
                   until valid
                       input1 = user_input.to_i
                       array = [1,2,3,4,5]
                   if !array.include?(input1)
                     puts " <<<<     INVALID     >>>>  ".red
                     puts ">>>> Pick one for more info:".bold
                   else
                     valid = true
                   end
                 end
                  get_drink_info(input1)
    end



    def get_drink_info(num)
        @drink_hash.each do |k,v|
            if num == k
              response_string= RestClient.get("https://www.thecocktaildb.com/api/json/v1/1/search.php?s=#{v}")
              api_helper(response_string)
              prompt =  ">>>> Would you like to add this cocktail to your Favorites? (Y/N)".bold
              valid_yes_or_no(prompt, ["yes", "no", "y", "n"])
              if @input == "y" || @input == "yes"
                Wish.create(user_id: @save_user.id, drink_id: @drink_id, drink_name: @drink_name)

            end
          end
        end
        after_save_favorite
    end



        def api_helper(response_string)
          response_hash = JSON.parse(response_string)
          @drinks = response_hash["drinks"]
          @drinks.map do |d|
            @drink_id = d["idDrink"]
            @drink_name = d["strDrink"]

          puts " ID: #{d["idDrink"]}"
          puts " NAME: #{d["strDrink"]}"
          puts " KEY INGREDIENTS:"
          puts "\t #{d["strIngredient1"]}"
          puts "\t #{d["strIngredient2"]}"
          puts "\t #{d["strIngredient3"]}"
          puts "\t #{d["strIngredient4"]}"
          display_rate(d["idDrink"].to_i)
          display_comment(@drink_id)
        end
        end






    def see_favorites
        favorite = Wish.all.where(user_id: @save_user.id)
        f_arr = favorite.map {|f| f.drink_name}
        if f_arr.length == 0
          puts "Oh, no! You have no favorites yet!".red
          menu_over_20
        else
          puts "*** You have #{f_arr.length} favorite(s). ***".bold
        f_arr.each do |n|
        # d_name = favorite.drink_name
        response_string= RestClient.get("https://www.thecocktaildb.com/api/json/v1/1/search.php?s=#{n}")
        api_helper(response_string)
                puts "*" * 5

              end
            end
            back_to_main
    end

    def cocktail_find_by_name
      puts "Please enter a cocktail name:"
      input1 = gets.chomp.to_s
      url = "https://www.thecocktaildb.com/api/json/v1/1/search.php?s=#{input1}"
      response_string= RestClient.get(url)
      api_helper(response_string)
        puts "*" * 5
      prompt =  ">>>> Would you like to a cocktail to your Favorites? (Y/N)".bold
      valid_yes_or_no(prompt, ["yes", "no", "y", "n"])
      if @input == "y" || @input == "yes"
        puts ">>>> Type in the exact drink ID here:".bold
        user_typed = gets.chomp.to_s
        picked = @drinks.select { |dr| dr["idDrink"] == user_typed }
        Wish.create(user_id: @save_user.id, drink_id: picked[0]["idDrink"].to_i , drink_name: picked[0]["strDrink"])
        puts "Your favorite has been saved"
      end
    # end
    after_save_favorite
    end









      def valid_yes_or_no(prompt, array)
        valid = false
        until valid
          puts prompt
          input = user_input.to_s.downcase
          if !array.include?(input)
            puts "<<<<   INVALID!!   >>>>".red.bold
          else
            valid = true
            @input = input
          end
        end
      end
