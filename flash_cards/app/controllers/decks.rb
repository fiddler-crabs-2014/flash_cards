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
  #redirect to '/decks_display'
  erb :statistics
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
    puts "CARD ANSWERS: #{@card_answers}"

    @guesses = Guess.where(round_id: session[:round_id])

    @correct_answers = []
    @guesses.each do |guess|
      @correct_answers << guess.correct_answer
    end
    puts "CORRECT ANSWERS: #{@correct_answers}"
    @remaining_answers = @card_answers - @correct_answers
    puts "REMAINING ANSWERS: #{@remaining_answers}"
    if @remaining_answers.empty?
      #redirect to '/decks_display'
      erb :statistics
    else
      # @sample = @remaining_questions.sample
      # @question = @sample.question
      # @answer = @sample.answer
      # @id = @sample.id
      @random_answer = @remaining_answers.sample
      @sample = Card.where(deck_id: @deck_id, answer: @random_answer).first
      @question = @sample.question
      @answer = @sample.answer
      @id = @sample.id
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
  puts "THIS IS THE ANSWER #{answer}"
  if @card.correct_answer?(answer)
    Guess.create(round: @round, correct_answer: @card.answer, correct: true)
    user = User.find(session[:user_id])
    user.score += 5
    user.save
    @round.add_score
  else
    Guess.create(round: @round, correct_answer: @card.answer, correct: false)
    user = User.find(session[:user_id])
    user.score -= 5
    user.save
    @round.subtract_score
  end
  @round.save
  @round.score.to_s
  # redirect '/go_to_deck/'+@deck_id.to_s
end

