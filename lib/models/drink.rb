require_relative "user.rb"
require 'rest-client'
require 'json'
require 'pry'

class Drink < ActiveRecord::Base

  has_many :ratings
  has_many :users, through: :ratings





end
