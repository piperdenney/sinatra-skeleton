get '/sessions/new' do
  erb :'/sessions/new'
end

post '/sessions' do
  user = User.find_by_email(params[:email])
  if user && user.password == params[:password]
    session[:user_id] = user.id
    redirect '/'
  else
    @errors = ['Invalid combination email or password']
    erb :'/sessions/new'
  end
end

delete '/sessions/:id' do
  session.clear
  redirect '/'
end