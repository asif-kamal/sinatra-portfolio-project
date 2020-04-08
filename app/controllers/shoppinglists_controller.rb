class ShoppingListsController < ApplicationController


  get '/shoppinglists' do
    @shoppinglist = Shoppinglist.all
    erb :'shoppinglists/index'
  end


  get '/shoppinglists/new' do
    if !Helpers.is_logged_in?(session)
      redirect '/'
    end
    erb :'shoppinglists/new'
  end

  post '/shoppinglists' do
    shoppinglist = Shoppinglist.create(params)
    user = Helpers.current_user(session)
    shoppinglist.user = user
    shoppinglist.save
    redirect to "/users/#{user.id}"
  end

  get '/shoppinglists/:id' do
    if !Helpers.is_logged_in?(session)
      redirect '/'
    end
    @shoppinglist = Shoppinglist.find_by(id: params[:id])
    if !@shoppinglist
      redirect to '/'
    end
    erb :'shoppinglists/show'
  end


  get '/shoppinglists/:id/edit' do
      @shoppinglist = Shoppinglist.find_by(id: params[:id])
    if !Helpers.is_logged_in?(session) || !@shoppinglist || @shoppinglist.user != Helpers.current_user(session)
      redirect '/'
    end
    erb :'/shoppinglists/edit'
  end

  patch '/shoppinglists/:id' do
    recipe = Shoppinglist.find_by(id: params[:id])
    if shoppinglist && shoppinglist.user == Helpers.current_user(session)
      shoppinglist.update(params[:shoppinglist])
      redirect to "/shoppinglists/#{shoppinglist.id}"
    else
      redirect to "/shoppinglists"
    end
  end

  delete '/shoppinglists/:id/delete' do
    shoppinglist = Shoppinglist.find_by(id: params[:id])
    if shoppinglist && shoppinglist.user == Helpers.current_user(session)
      shoppinglist.destroy
    end
    redirect to '/shoppinglists'
  end

end
