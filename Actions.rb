# Homepage (Root path)
helpers do
def current_user
  @current_user = User.find_by(id: session[:user_id]) if session[:user_id]
end


get '/' do
  erb :index
end

get '/login' do
  erb :login
end

get '/signup' do
  erb :login
end

def user_params
    params.require(:user).permit(:email, :password, :username)
  end

post '/login' do
  user = User.find_by_email(params[:username][:email])
  if user.password == password
    session[:user_id] = user.id
    redirext '/'
  else
    redirect '/login'
  end
end

post '/signup' do
  user = User.find_by(username: username)
  if user
    redirext '/signup'
  else
    user = User.create(username: username, password: password)
    session[:user_id] = user.id
    redirect '/login'
  end
end
