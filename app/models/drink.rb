class Drink < ActiveRecord::Base
  has_many :ratings
  has_many :users, through: :ratings

  def liquor_type
    puts "What type of liquor would you like to drink?"
    



end
