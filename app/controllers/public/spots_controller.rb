class Public::SpotsController < ApplicationController
  before_action :authenticate_user!, except: [:show, :index]
  before_action :ensure_correct_user, only: [:edit, :update, :destroy]

  def new
    @spot = Spot.new
  end

  def index
    @spots = Spot.all
  end

  def show
    @spot = Spot.find(params[:id])
    @comment = Comment.new
    @comments = Comment.where(spot_id: @spot.id).order(created_at: :desc)
    @user = @spot.user

    # 関連書籍プルダウン
    post_managements = PostManagement.where(spot_id: @spot.id)
    @books = post_managements.where(post_type: "spot")
    book_ids = @books.pluck(:book_id)
    @select_books = Book.where(id: book_ids)
  end

  def create
    @spot = Spot.new(spot_params)
    @spot.user_id = current_user.id
    if @spot.save
      PostManagement.create(book_id: @spot.book_id, spot_id: @spot.id, post_type: @spot.post_type)
      redirect_to spot_path(@spot), notice: "スポットを新規登録しました。"
    else
      @spots = Spot.all
      render "new"
    end
  end

  def edit
    @spot = Spot.find(params[:id])
  end

  def update
    @spot = Spot.find(params[:id])
    if @spot.update(spot_params)
      post_management = PostManagement.find_by(spot_id: @spot.id)
      if post_management
        post_management.update(book_id: @spot.book_id, post_type: @spot.post_type)
      else
        PostManagement.create(book_id: @spot.book_id, spot_id: @spot.id, post_type: @spot.post_type)
      end
      redirect_to spot_path(@spot), notice: "スポット情報を更新しました。"
    else
      rend
    end
  end

  def destroy
    @spot = Spot.find(params[:id])
    @spot.destroy
    redirect_to mypage_users_path
  end

  private

  def spot_params
    params.require(:spot).permit(:name, :spot_image, :address, :post_type, :book_id)
  end

  def ensure_correct_user
    @spot = Spot.find(params[:id])
    unless @spot.user == current_user
      redirect_to spots_path
    end
  end
  
end
