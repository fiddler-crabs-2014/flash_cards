class Round < ActiveRecord::Base
  # Remember to create a migration!
  belongs_to :deck
  belongs_to :user
  has_many :guesses

  def add_score
    self.score += 1
  end

  def subtract_score
    self.score -= 0
  end
end


