
get '/login' do

  erb :login
end





post '/login' do
  email = params[:email]
  password = params[:password]
  @user = User.authenticate(email, password)
  if @user
    session[:user_id] = @user.id
    erb :index
  else
    @message = "that does not match our records"
    redirect to '/login'
  end
end
