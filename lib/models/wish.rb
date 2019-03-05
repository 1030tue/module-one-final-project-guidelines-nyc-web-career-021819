class Wish < ActiveRecord::Base
  belongs_to :user
  belongs_to :drink

  def self.add_to_favorites
      # puts "Do you want to add to your favorites? Y/N"
      # input = self.user_input
      # if input.downcase == "y"


      #self.create(user_id, all info from hash)
      #if no
      #back to main manu or do you want to see more cocktals based on this liquor?
    end

    def self.user_input
      input = gets.chomp
      input.to_s
    end


    def see_favorites
    end


    def delete_favorites
    end




end
