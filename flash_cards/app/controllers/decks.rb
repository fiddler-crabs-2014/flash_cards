get "/decks_display" do
  if session[:user_id]
    @decks = Deck.all
    session[:round_id] = nil
    erb :decks_display
  else
    redirect to '/login'
  end
end

post "/decks_display/:user_score" do
  # @decks = Deck.all
  @user_score = params[:user_score]
  @user_id = session[:user_id]
  @user = User.find(@user_id)
  @user.score = @user_score
  redirect to '/decks_display'
end

get "/go_to_deck/:id" do
  if session[:user_id]
    @deck_id = params[:id]
    @cards = Card.where("deck_id = ?", @deck_id)

    unless session[:round_id]
      @round =  Round.create({user_id: session[:user_id], deck_id: params[:id]})
      session[:round_id] = @round.id
    end

    @card_answers = []
    @cards.each do |card|
      @card_answers << card.answer
    end

    @guesses = Guess.where(round_id: session[:round_id])

    @correct_answers = []
    @guesses.each do |guess|
      @correct_answers << guess.correct_answer
    end

    @remaining_questions = @card_answers - @correct_answers

    if @remaining_questions.empty
      #redirect to '/decks_display'
      erb :index
    else
      @sample = @remaining_questions.sample
      @question = @sample.question
      @answer = @sample.answer
      @id = @sample.id
    end

   erb :go_to_deck, layout: false
  else
    redirect '/login'
  end
end



post '/answer' do
  card_id = params[:card_id]
  @card = Card.find(card_id)

  answer = params[:answer]
  @round = Round.find(session[:round_id])
  @deck_id =  @round.deck_id

  if @card.correct_answer?(answer)
    Guess.create(round: @round, guess: answer, correct: true)
    user = User.find(session[:user_id])
    user.score += 5
    user.save
    @round.add_score
  else
    Guess.create(round: @round, guess: answer, correct: false)
    user = User.find(session[:user_id])
    user.score -= 5
    user.save
    @round.subtract_score
  end
  @round.save
  @round.score.to_s

  # redirect '/go_to_deck/'+@deck_id.to_s
end

