get "/decks_display" do
  @decks = Deck.all

  erb :decks_display
end

get "/go_to_deck/:id" do

  @deck_id = params[:id]

  @cards = Card.where("deck_id = ?", @deck_id)

  @sample = @cards.sample
  #@question = sample.question
  #@answer = sample.answer

  erb :go_to_deck
end
