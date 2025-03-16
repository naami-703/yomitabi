class Public::Books::CommentsController < ApplicationController

  def create
    @book = Book.find(params[:book_id])
    @comment = current_user.comments.new(comment_params)
    @comment.book_id = @book.id 
    i@comment.save
  end
  
  def destroy
    @comment = Comment.find_by(id: params[:id])
    if @comment.present?
      @comment.destroy
      @book = @comment.book
      @comments = @book.comments
    else
      flash[:error] = "コメントが見つかりませんでした"
    end
    respond_to do |format|
      format.js
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:comment, :book_id, :comment_image)
  end

end
