class BooksController < ApplicationController
  get '/books' do
    @books = Book.all

    erb :'books/books'
  end

  # This request needs to go before <<get '/books/:slugtitle' do>> request.
  # Otherwise, the app will think that the "new" segment below is a dynamic (:slugtitle) route
  get '/books/new' do

    if logged_in?
      erb :'books/create_book'
    else
      flash[:message_for_login_page] ="Oops, sorry but you must login below or sign up here first before creating a new book."
      redirect to '/login'
    end
  end

  post '/books' do
    # This will generate a Sinatra error page and show the hash being passed:
    # raise params.inspect
    if logged_in?
      if Book.new(params[:book]).valid?                 # 'valid?' is an ActiveRecord method
        @book = current_user.books.build(params[:book]) # ActiveRecord "build" method will not save @book like "create" method
                    # We need this operation between 'build' and 'save'
        @book.save
        redirect to "/books"
      else
        flash[:message_for_new_book_page] = "Sorry, but that book title is already taken, please choose another title."
        redirect to "/books/new"
      end
    end
  end

  get '/books/:title' do
    @books = Book.all
    @book = @books.find_by_title(params[:title])
    erb :'books/show_book'
  end

  get '/books/:title/edit' do # This ie exactly the same as "'/books/new' do" above


    if logged_in?
      @books = Book.all
      @book = @books.find_by_title(params[:title])
      if @book && @book.user == current_user
        erb :'books/edit_book'
      else
        flash[:books_index_page_message] = "Sorry, but you don't have permission to edit a book you didn't create."
        redirect to '/books'
      end
    else
      redirect to '/login'
    end
  end

  # patch requests are used to send user edits
  patch '/books/:title' do
    if logged_in?
      @books = Book.all
      @book = @books.find_by_title(params[:title])
      if @book && @book.user == current_user
        if @book.update(params[:book]) != true
          flash[:message_for_new_book_page] = "Sorry, but that book title is already taken, please choose another title."
          redirect to '/books/new'
        end

      else
        flash[:message_for_login_page] = "Sorry, but you don't have permission to edit a book you didn't create."
        erb :'users/login'
      end
      erb :'books/show_book'
    end
  end

  delete '/books/:title/delete' do
    if logged_in?
      @books = Book.all
      @book = @books.find_by_title(params[:title])
      if @book.user_id == current_user.id
        @book.delete
        redirect to '/books'
      else
        redirect to '/books'
      end
    else
      redirect to '/login'
    end
  end
end
