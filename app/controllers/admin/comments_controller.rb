class Admin::CommentsController < ApplicationController
  before_action :authenticate_admin!

  def index 
    @user = User.find(params[:user]) 
    @comments_book = Comment.where(user_id: @user.id, spot_id: nil).where.not(book_id: nil).order(created_at: :desc).page(params[:page]).per(12)
    @comments_spot = Comment.where(user_id: @user.id).where.not(spot_id: nil).order(created_at: :desc).page(params[:page]).per(12)
  end
  
  def destroy
    @comments_book = Comment.find_by(id: params[:id])
    @comments_spot = Comment.find_by(id: params[:id])
    if @comments_book
       @comments_book.destroy
    end
    
    if @comments_spot
       @comments_spot.destroy
    end
    
    redirect_to request.referer
  end

end
