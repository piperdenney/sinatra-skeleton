get '/users/new' do
  erb :'/users/new'
end

post '/users' do
  user = User.new(params[:user])
  user.password = params[:password]
  if user.save
    redirect "/sessions/new"
  else
    @errors = user.errors.full_messages
    p @errors
    erb :'/users/new'
  end
end


get '/users/:id/entries' do
  @user = User.find_by(id: params[:id])
  if @user.nil?
    @errors = ["Sorry, we couldn't find what you were looking for.","User dose not exists!"]
    @entries = Entry.most_recent
    erb :'entries/index'
  else
    @entries = @user.entries
    erb :'/users/show'
  end
end