class UsersController < ApplicationController
  before_action :correct_user, only: [:edit, :update]
  def show
     @user = User.find(params[:id])
     @books = @user.books
     @book = Book.new
  end

  def edit
    @user = User.find(params[:id])
  end


  def update
    @user = User.find(params[:id])#ユーザーの取得
    if @user.update(user_params)#ユーザーのアップデート
      flash[:notice] = "You have updated user successfully."
      redirect_to user_path(@user.id)#ユーザーの詳細ページへのパス
    else
      render :edit
    end
  end

  def index
    @user = current_user
    @users = User.all
    @book = Book.new
  end

  private

  def user_params
    params.require(:user).permit(:name, :profile_image, :introduction)
  end
  
  def correct_user
    @book = Book.find(params[:id])
    @user = User.find(params[:id])
    redirect_to(user_path(current_user.id)) unless @user == current_user
  end
end
