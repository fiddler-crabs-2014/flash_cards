class Deck < ActiveRecord::Base
  has_many :card
  has_many :rounds
  has_many :users, through: :rounds
  # Remember to create a migration!
end
