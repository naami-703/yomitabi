class Public::UsersController < ApplicationController
  before_action :authenticate_user!, except: [:top, :about]
  before_action :ensure_correct_user, only: [:update, :edit, :destroy]

  def mypage
    @user = current_user
    @books = @user.books
    @spots = @user.spots
  end

  def show
    @user = User.find(params[:id])
    @books = @user.books
    @spots = @user.spots
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
