
# route handlers dealing with the collection
get '/entries' do
  @entries = Entry.most_recent
  erb :'entries/index'
end

post '/entries' do
  @entry = Entry.new(params[:entry])
  @entry.user_id = session[:user_id]
  if @entry.save
    if request.xhr?
      erb :'/entries/_entry', locals: {entry: @entry}, layout: false
    else
      redirect "/entries/#{@entry.id}"
    end
  else
    @errors = @entry.errors.full_messages
    if request.xhr?
      content_type :json
      @errors.map {|x| x }.join("\n").to_json
    else
      status 404
      erb :'entries/new'
    end
  end
end

get '/entries/new' do
  if request.xhr?
    erb :'entries/new', layout: false
  else
    if session[:user_id].nil?
      @errors = ["Sorry, we couldn't find what you were looking for.", "You need to login in order to access this page."]
      @entries = Entry.most_recent
      erb :'entries/index'
    else
      erb :'entries/new'
    end
  end
end

get '/entries/:id' do
  @entry = find_and_ensure_entry(params[:id])
  erb :'entries/show'
end

put '/entries/:id' do
  @entry = find_and_ensure_entry(params[:id])
  @entry.assign_attributes(params[:entry])
  if @entry.save
    redirect "entries/#{@entry.id}"
  else
    @errors = @entry.errors.full_messages
    erb :'entries/edit'
  end
end

delete '/entries/:id' do
  @entry = find_and_ensure_entry(params[:id])
  if session[:user_id] != @entry.user.id
    @errors = ["Sorry, we couldn't find what you were looking for.", "You need to login in order to access this page."]
    @entries = Entry.most_recent
    erb :'entries/index'
  else
    @entry.destroy
    redirect "/users/#{@entry.user.id}/entries"
  end
end

get '/entries/:id/edit' do
  @entry = find_and_ensure_entry(params[:id])
  if session[:user_id] != @entry.user.id
    @errors = ["Sorry, we couldn't find what you were looking for.", "You need to login in order to access this page."]
    @entries = Entry.most_recent
    erb :'entries/index'
  else
    erb :'entries/edit'
  end
end