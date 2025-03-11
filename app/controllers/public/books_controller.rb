class Public::BooksController < ApplicationController
  before_action :authenticate_user!, except: [:show, :index]
  before_action :ensure_correct_user, only: [:edit, :update, :destroy]

  def new
    @book = Book.new
  end

  def index
    @books = Book.all
  end

  def show
    @book = Book.find(params[:id])
    @user = @book.user
    @genre = @book.genre
  end

  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    if @book.save
      redirect_to book_path(@book), notice: "書籍を新規登録しました。"
    else
      render "new"
    end
  end

  def edit
    @book = Book.find(params[:id])
  end

  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
      redirect_to book_path(@book), notice: "書籍情報を更新しました。"
    else
      render "edit"
    end
  end

  def destroy
    @book = Book.find(params[:id])
    @book.destroy
    redirect_to mypage_users_path
  end

  private

  def book_params
    params.require(:book).permit(:title, :book_image, :genre_id, :post_type)
  end

  def ensure_correct_user
    @book = Book.find(params[:id])
    unless 
      @book.user == current_user
      redirect_to mypage_users_path
    end
  end
  
end
