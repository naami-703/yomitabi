class Public::Spots::CommentsController < ApplicationController

  def create
    @spot = Spot.find(params[:spot_id])
    @comment = current_user.comments.new(comment_params)
    @comment.spot_id = @spot.id
    @comment.save
  end
  
  def destroy
    @comment = Comment.find_by(id: params[:id])
    if @comment.present?
      @comment.destroy
      @spot = @comment.spot
      @comments = @spot.comments
    else
      flash[:error] = "コメントが見つかりませんでした"
    end
    respond_to do |format|
      format.js
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:comment, :spot_id, :book_id, :comment_image)
  end

end
