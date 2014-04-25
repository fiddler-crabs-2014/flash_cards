
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
   # @message = "that does not match our records"
    redirect to '/login'
  end
end



post '/sign_up' do
  @email = params[:email]
  @password = params[:password]
  @name = params[:name]
  user = User.where(["email=?", @email]).first
  if user.nil?
    @user = User.create(email: @email, password: @password, name: @name)
    session[:user_id] = @user.id
    erb :index
  else
   #@message = "I'm sorry, someone has that email"
    redirect to '/login'
  end
end




