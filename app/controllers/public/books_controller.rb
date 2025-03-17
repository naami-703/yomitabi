class Public::BooksController < ApplicationController
  before_action :authenticate_user!, except: [:show, :index]
  before_action :ensure_correct_user, only: [:edit, :update, :destroy]

  def new
    @book = Book.new(book_id: params[:book_id])
  end

  def index
    @books = Book.all
  end

  def show
    @book = Book.find(params[:id])
    @post_management = PostManagement.find_by(book_id: @book.id)
    @post_managements = PostManagement.where(book_id: @book.id)
    @spots = @post_managements.where(post_type: "spot").includes(:spot) 
    @spots_index = @spots.map(&:spot)

    @comment = Comment.new
    @comments = Comment.where(book_id: @book.id).where(spot_id: nil).includes(:book).order(created_at: :desc)
    @user = @book.user
    @genre = @book.genre
  end

  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    if @book.save
      PostManagement.create(post_type: @book.post_type)
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

    if params[:spot_id].present?
      # 登録済みのSpotを選択した場合の処理
      post_management = PostManagement.find_by(book_id: @book.id)
  
      if post_management
        post_management.update(spot_id: params[:spot_id])
      else
        PostManagement.create(book_id: @book.id, spot_id: params[:spot_id])
      end
  
      redirect_to book_path(@book), notice: "書籍情報を更新しました。"
    else
      # 未登録のSpot用の処理を記述
  
      if @book.update(book_params)
        redirect_to book_path(@book), notice: "書籍情報を更新しました。"
      else
        render :edit
      end
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
