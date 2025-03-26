class Public::PostManagementsController < ApplicationController

  def show
    @post_management = PostManagement.find(params[:id])
  end

  def create
    post_management = PostManagement.find_by(book_id: post_management_params[:book_id], spot_id: post_management_params[:spot_id])
    if @post_management.save
    else
      flash[:error] = @post_management.errors.full_messages.to_sentence
    end
  end

  def update
    @post_management = PostManagement.find(params[:id])
    new_post_management = PostManagement.new(post_management_params)
    new_post_management.save
  end

  def destroy
    @post_management = PostManagement.find(params[:id])
    @post_management.destroy
  end

  private

  def post_management_params
    params.require(:post_management).permit(:book_id, :spot_id, :post_type)
  end
  
end
