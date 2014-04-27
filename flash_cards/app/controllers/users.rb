
get '/login' do
  # @message = false
  # @text = "what you like to do"
  @message = session[:message]
  erb :login
end





post '/login' do
  email = params[:email]
  password = params[:password]
  @user = User.authenticate(email, password)
  if @user
    session[:user_id] = @user.id
    session[:name] = @user.name
    redirect to '/decks_display'
  else
    session[:message] = ["That does not match our records!"]
    redirect to '/login'
  end
end



post '/sign_up' do
  @email = params[:email]
  @password = params[:password]
  @name = params[:name]
  @user = User.create({email: @email, password: @password, name: @name})
  if @user.valid?
    session[:user_id] = @user.id
    session[:name] = @user.name
    redirect to '/decks_display'
  else
    session[:message] = @user.errors.full_messages
    redirect to '/login'
  end

end

post '/logout' do
  session.destroy
  session[:message] = ["Logged out successfully!!"]
  redirect to '/login'

end

get '/show_all_results' do

  @deck_results =[]
  puts @all_decks = Deck.all
  @all_decks.inspect
  @all_deck_names=[]
  @all_decks.each do |deck|
    @all_deck_names << deck.name
  end

  @all_deck_names

  for i in (1..Deck.count)
    @deck_results << Round.where(user_id: session[:user_id], deck_id: i)
  end

  # @deck_results.each_with_index do |deck, index|
  #      puts @name_thing = @all_decks[index].name
  #       deck.each do |round|
  #       print round
  #   end
  # end


  erb :all_results
end


