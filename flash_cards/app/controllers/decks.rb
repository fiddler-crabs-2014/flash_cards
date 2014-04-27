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
  @user_score = params[:user_score]
  @user_id = session[:user_id]
  @user = User.find(@user_id)
  @user.score = @user_score
  unless session[:round_id] == nil
    @round = Round.find(session[:round_id])
    @deck_id =  @round.deck_id
    @deck = (Deck.where(id: @deck_id)).first
    @total_questions = @deck.cards.count
    @round = Round.find(session[:round_id])
    @percentage = ((@round.score.to_f/@total_questions.to_f)*100).round(2)
    @round.score = @percentage
    @round.save
    @all_rounds = Round.where(user_id: session[:user_id], deck_id: @deck_id)
    @num_correct = Guess.where(round_id: session[:round_id], correct: true).count
  end
  erb :statistics
end

get "/go_to_deck/:id" do
  if session[:user_id]
    p @deck_id = params[:id]
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

    @remaining_answers = @card_answers - @correct_answers
    if @remaining_answers.empty? && @deck_id != "2"
      @round = Round.find(session[:round_id])
      @percentage = (@round.score.to_f/@cards.count.to_f)*100
      @round.score = @percentage.round(2)
      @round.save
      erb :statistics
    elsif @deck_id == "2"
      @sample = @cards.sample
      @question = @sample.question
      @answer = @sample.answer
      @id = @sample.id
      @user_score = User.find(session[:user_id]).score
      @round_score = Round.find(session[:round_id]).score
      erb :go_to_deck, layout: false
    else
      @random_answer = @remaining_answers.sample
      @sample = Card.where(deck_id: @deck_id, answer: @random_answer).first
      @question = @sample.question
      @answer = @sample.answer
      @id = @sample.id
      @questions_remaining = @remaining_answers.count
      @user_score = User.find(session[:user_id]).score
      @round_score = Round.find(session[:round_id]).score
      erb :go_to_deck, layout: false
    end

   #erb :go_to_deck, layout: false
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
    Guess.create(round: @round, correct_answer: @card.answer, correct: true)
    user = User.find(session[:user_id])
    user.score += 5
    user.save
    @round.add_score
    @result = "<span class=\"alert alert-success\">Correct! +5 points!</span>"
  else
    Guess.create(round: @round, correct_answer: @card.answer, correct: false)
    user = User.find(session[:user_id])
    user.score -= 5
    user.save
    @round.subtract_score
    @result = "<span class=\"alert alert-danger\">Incorrect! :( -5 points!</span>"
  end
  @deck = (Deck.where(id: @deck_id)).first
  @total_questions = @deck.cards.count

  @round.save
  #divide round score by total cards in deck to get percentage
  #@round.score.to_s
  @result
  # redirect '/go_to_deck/'+@deck_id.to_s
end

