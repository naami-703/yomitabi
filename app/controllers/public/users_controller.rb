class Public::UsersController < ApplicationController
  before_action :authenticate_user!, except: [:top, :about]
  before_action :ensure_correct_user, only: [:update, :edit, :destroy]

  def mypage
    @user = current_user
    @books = @user.books
    @books_new = @books.order(created_at: :desc)
    @spots = @user.spots
    @spots_new = @spots.order(created_at: :desc)
  end

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
    @books = @user.books
    @books_new = @books.order(created_at: :desc)
    @spots = @user.spots
    @spots_new = @spots.order(created_at: :desc)
  end

  def edit
    @user = current_user
  end

  def update
    @user = current_user
    if @user.update(user_params)
      flash[:notice] =  "更新に成功しました"
      redirect_to mypage_users_path
    else
      render :edit
    end
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    redirect_to root_path
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :profile_image, :favorite_books, :introduction)
  end

  def ensure_correct_user
    @user = User.find(params[:id])
    unless @user == current_user
      redirect_to user_path(current_user)
    end
  end

end
