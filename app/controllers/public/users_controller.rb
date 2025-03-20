class Public::UsersController < ApplicationController
  before_action :authenticate_user!, except: [:top, :about]
  before_action :ensure_correct_user, only: [:update, :edit, :destroy]

  def mypage
    @user = current_user

    @books = @user.books
    @genres = @books.map { |book| book.genre }
    @books_new = @books.order(created_at: :desc)
    @comments_book = @user.comments.where.not(book_id: nil).where(spot_id: nil).order(created_at: :desc)

    @spots = @user.spots
    @spots_new = @spots.order(created_at: :desc)
    @comments_spot = @user.comments.where.not(spot_id: nil).order(created_at: :desc)

    bookmarks = Bookmark.where(user_id: @user.id).pluck(:book_id)
    @bookmarks_selected = Book.find(bookmarks)
    @bookmarks_book = @bookmarks_selected.map { |book| book }
  end

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])

    @books = @user.books
    @genres = @books.map { |book| book.genre }
    @books_new = @books.order(created_at: :desc)
    @comments_book = @user.comments.where.not(book_id: nil).where(spot_id: nil).order(created_at: :desc)

    @spots = @user.spots
    @spots_new = @spots.order(created_at: :desc)
    @comments_spot = @user.comments.where.not(spot_id: nil).order(created_at: :desc)
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
      render 'edit'
    end
  end

  def destroy
    @user = current_user
    @user.destroy
    redirect_to new_user_registration_path
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :profile_image, :favorite_books, :introduction)
  end

  def ensure_correct_user
    @user = User.find(params[:id])
    unless @user == current_user
      redirect_to new_user_session_path
    end
  end

end
