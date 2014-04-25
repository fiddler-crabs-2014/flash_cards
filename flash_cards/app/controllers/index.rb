get '/' do
  # Look in app/views/index.erb
  if session[:user_id]
    @user_id = session[:user_id]
    erb :index
  else
    session[:message] = nil
    redirect to '/login'
  end
end
