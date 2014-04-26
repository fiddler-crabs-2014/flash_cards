get "/decks_display" do
  @decks = Deck.all

  erb :decks_display
end

get "/go_to_deck/:id" do
  #@cards = params[:cards]
  unless session[:round_id]
    puts "HIT ___________________________"
    @round =  Round.create({user_id: session[:user_id], deck_id: params[:id]})
    session[:round_id] = @round.id
    puts "CARD CLASS #{@cards.class}"
  end
  @deck_id = params[:id]
  @cards = Card.where("deck_id = ?", @deck_id)
  #@cards = Card.where("deck_id = ?", @deck_id)
  #puts "CARD COUNT: #{@cards.length}"

  @sample = @cards.shuffle.pop
  @question = @sample.question
  @answer = @sample.answer
  @id = @sample.id
  #@question = sample.question
  #@answer = sample.answer
  #puts "SAMPLE INSPECT: #{@sample.inspect}"
  #puts "SAMPLE question: #{@sample.question}"
  @cards
  erb :go_to_deck
end



post '/answer' do
  card_id = params[:card_id]
  @card = Card.find(card_id)
  #puts "CARD OBJECT: #{@card.inspect}"
  answer = params[:answer]
  @round = Round.find(session[:round_id])
  @deck_id =  @round.deck_id
  if @card.correct_answer?(answer)
    user = User.find(session[:user_id])
    user.score += 5
    user.save
    @round.add_score
  else
    user = User.find(session[:user_id])
    user.score -= 5
    user.save
    @round.subtract_score
  end
  @round.save
  @round.score.to_s
  #puts "ROUND OBJECT: #{@round.inspect}"
  #puts "ROUND SCORE: #{@round.score}"
  # sleep(3.0)

  # redirect '/go_to_deck/'+@deck_id.to_s
end
