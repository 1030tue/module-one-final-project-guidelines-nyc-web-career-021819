

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


    # valid = false
    #   until valid
    #       input1 = user_input.to_i
    #       array = [1,2,3,4,5]
    #   if !array.include?(input1)
    #     puts " <<<<     INVALID     >>>>  \n>>>> Pick one for more info:"
    #   else
    #     valid = true
    #   end
    # end
    #  get_drink_info(input1)



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

              puts ">>>> Do you want to add to your favorites? Y/N"

              valid = false
                until valid
                array = ["yes", "no", "y", "n"]
                input1 = user_input.to_s.downcase
                if !array.include?(input1)
                  puts " <<<<     INVALID     >>>> \n>>>> Do you want to add this drink to your favorites? Y/N"

                else
                  valid = true
                end
              end

              if input1 == "y"
                Wish.create(user_id: @save_user, drink_id: drink_id, drink_name: drink_name)
              end
            end
          end
        end
        after_save_favorite
    end


    def see_favorites
        favorite = Wish.all.where(user_id: @save_user)
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
