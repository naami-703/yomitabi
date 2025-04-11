class Public::SpotsController < ApplicationController
  before_action :authenticate_user!, except: [:show, :index]
  before_action :ensure_correct_user, only: [:edit, :update, :destroy]

  def new
    @spot = Spot.new(book_id: params[:book_id])
  end

  def index
    spots_want_to_gos = Spot.includes(:want_to_gos)
    spots_wents = Spot.includes(:wents)

    if params[:new]
      @spots = Spot.order(created_at: :desc).page(params[:page])
    elsif params[:old]
      @spots = Spot.order(created_at: :asc).page(params[:page])
    elsif params[:want_to_go]
      sorted_spots = spots_want_to_gos.sort_by { |spot| -spot.want_to_gos.size }
      @spots = Kaminari.paginate_array(sorted_spots).page(params[:page])
    elsif params[:went]
      sorted_spots = spots_wents.sort_by { |spot| -spot.wents.size }
      @spots = Kaminari.paginate_array(sorted_spots).page(params[:page])
    else
      @spots = Spot.page(params[:page])
    end

  end

  def show
    @spot = Spot.find(params[:id])
    @post_management = PostManagement.find_by(spot_id: @spot.id)
    post_managements = PostManagement.where(spot_id: @spot.id)
    @books = post_managements.where(post_type: "spot").includes(:book) 
    @books_index = @books.map(&:book).compact

    @comment = Comment.new
    @comments = Comment.where(spot_id: @spot.id).order(created_at: :desc)
    @user = @spot.user

    # 関連書籍プルダウン
    book_ids = @books.pluck(:book_id)
    @select_books = Book.where(id: book_ids)
  end

  def create
    @spot = Spot.new(spot_params)
    @spot.user_id = current_user.id
    if @spot.save
      PostManagement.create(spot_id: @spot.id, book_id: @spot.book_id, post_type: @spot.post_type)
      redirect_to spot_path(@spot), notice: "スポットを新規登録しました。"
    else
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
      render "edit"
    end
  end

  def destroy
    @spot = Spot.find(params[:id])
    @spot.destroy
    redirect_to mypage_users_path
  end

  private

  def spot_params
    params.require(:spot).permit(:name, :spot_image, :address_prefectures,:address_googlemap, :post_type, :book_id)
  end

  def ensure_correct_user
    @spot = Spot.find(params[:id])
    unless @spot.user == current_user
      redirect_to spots_path
    end
  end
  
end
