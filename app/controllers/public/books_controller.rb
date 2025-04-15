class Public::BooksController < ApplicationController
  before_action :authenticate_user!, except: [:show, :index]
  before_action :ensure_correct_user, only: [:edit, :update, :destroy]

  def new
    @book = Book.new(spot_id: params[:spot_id], title: params[:title], author: params[:author], image_url: params[:image_url], isbn: params[:isbn])
  end

  def index
    books = Book.includes(:bookmarks)

    if params[:new]
      @books = Book.order(created_at: :desc).page(params[:page])
    elsif params[:old]
      @books = Book.order(created_at: :asc).page(params[:page])
    elsif params[:bookmark]
      sorted_books = books.sort_by { |book| -book.bookmarks.size }
      @books = Kaminari.paginate_array(sorted_books).page(params[:page])
    else
      @books = Book.page(params[:page])
    end
  end

  def show
    @book = Book.find(params[:id])
    @post_management = PostManagement.find_by(book_id: @book.id)
    post_managements = PostManagement.where(book_id: @book.id)
    @spots = post_managements.where(post_type: "spot").includes(:spot) 
    @spots_index = @spots.map(&:spot).compact

    @comment = Comment.new
    @comments = Comment.where(book_id: @book.id).where(spot_id: nil).includes(:book).order(created_at: :desc)
    @user = @book.user
    @genre = @book.genre
  end

  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    if @book.save
      PostManagement.create(book_id: @book.id, spot_id:@book.spot_id, post_type: @book.post_type)
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
      post_management = PostManagement.find_by(book_id: @book.id)
      if post_management
        post_management.update(spot_id: @book.spot_id, post_type: @book.post_type)
      else
        PostManagement.create(spot_id: @book.spot_id, book_id: @book.id, post_type: @book.post_type)
      end
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

  def search
    if params[:keyword].blank?
      redirect_to request.referer
    elsif params[:keyword]
      @books = RakutenWebService::Books::Book.search(title: params[:keyword])
    end
  end
  
  private

  def book_params
    params.require(:book).permit(:title, :author, :image_url, :isbn, :genre_id, :post_type)
  end

  def ensure_correct_user
    @book = Book.find(params[:id])
    unless 
      @book.user == current_user
      redirect_to mypage_users_path
    end
  end
  
end
