class Admin::CommentsController < ApplicationController
  before_action :authenticate_admin!

  def index 
    @books = Book.all
    @spots = Spot.all
    @book_comments = Comment.where(book_id: @books.pluck(:id), spot_id: nil).order(created_at: :desc)
    @spot_comments = Comment.where(spot_id: @spots.pluck(:id)).where.not(book_id: nil).order(created_at: :desc)
  end
  
  def destroy
    @book_comment = Comment.find_by(id: params[:id])
    @spot_comment = Comment.find_by(id: params[:id])
    if @book_comment
      @book_comment.destroy
    end
    
    if @spot_comment
      @spot_comment.destroy
    end
    
    redirect_to request.referer
  end

end
