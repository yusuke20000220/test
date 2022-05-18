class BooksController < ApplicationController
    before_action :correct_user, only: [:edit]
  def new

    @book = Book.new
  end

  def index
     @book = Book.new
     @user = current_user
     @books = Book.all
  end

  def show
    @book = Book.new
    @book2 = Book.find(params[:id])
    @user = @book2.user
  end

  def destroy
    @book = Book.find(params[:id])
    @book.destroy
    redirect_to books_path
  end

   def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
   if  @book.save
    flash[:notice] = "You have created book successfully."
    redirect_to book_path(@book.id)
   else
     @books = Book.all
     @user = current_user
     render :index
   end
   end

   def edit
    @book = Book.find(params[:id])
   end

   def update
    @book = Book.find(params[:id])#ユーザーの取得
    if @book.update(book_params)#ユーザーのアップデート
        flash[:notice] = "You have updated book successfully."
        redirect_to book_path(@book.id)#ユーザーの詳細ページへのパス
    else
        @books = Book.all
        @user = current_user
        render :edit
    end
   end

   private

  def book_params
    params.require(:book).permit(:title, :body)
  end

  def correct_user
    @book = Book.find(params[:id])
    @user = @book.user
    redirect_to(books_path) unless @user == current_user
  end

end
