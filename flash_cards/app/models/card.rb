class Card < ActiveRecord::Base
  belongs_to :deck
  # Remember to create a migration!


  def correct_answer?(guess)
    #@card = Card.where(question: question)
    if @answer == guess
      return true
    else
      return false
    end
  end

end
