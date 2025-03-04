class Public::UsersController < ApplicationController

  before_action :authenticate_user!
  before_action :ensure_correct_user, only: [:update, :edit]

  def mypage
  end

  def show
    @user = User.find(params[:id])
    @books = @user.books
    @book = Book.new
    @comments = BookComment.new
  end

  def edit
    @user = current_user
  end

  def update
    @user = current_user
    if @user.update(user_params)
      flash[:notice] =  "You have updated user successfully."
      redirect_to users_path
    else
      render :edit_user
    end
  end

  def destroy
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :profile_image)
  end

  def ensure_correct_user
    @user = User.find(params[:id])
    unless @user == current_user
      redirect_to user_path(current_user)
    end
  end

end
