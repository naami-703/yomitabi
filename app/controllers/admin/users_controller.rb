class Admin::UsersController < ApplicationController
  before_action :authenticate_admin!

  def index 
    users = User.all
    @users = users.order(created_at: :desc).page(params[:page]).per(12)
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to admin_users_path, notice: "会員情報を更新しました。"
    else
      render "edit"
    end
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    redirect_to admin_users_path
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :profile_image, :favorite_books, :introduction)
  end

end
