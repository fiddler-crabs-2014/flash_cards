get "/decks_display" do
  @decks = Deck.all

  erb :decks_display
end
