  require_relative 'drink.rb'
class User < ActiveRecord::Base
  has_many :ratings
  has_many :drinks, through: :ratings
  # validates :name, presence: true



end
