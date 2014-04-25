
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
    redirect to '/decks_display'
  else
    session[:message] = @user.errors.full_messages
    redirect to 'login'
  end

end

post '/logout' do
  session.destroy
  session[:message] = ["Logged out successful!!"]
  redirect to '/login'

end



