class Public::PostManagementsController < ApplicationController

  def show
    @post_management = PostManagement.find(params[:id])
  end

  def create
    @post_management = PostManagement.new(post_management_params)
    @post_management.save
  end

  def update
    @post_management = PostManagement.find(params[:id])
    @post_management.update(post_management_params)
    end
  end

  def destroy
    @post_management = PostManagement.find(params[:id])
    @post_management.destroy
  end

  private

  def post_management_params
    params.require(:post_management).permit(:book_id, :spot_id :class Public::PostManagementsController < ApplicationController

    def show
      @post_management = PostManagement.find(params[:id])
    end
  
    def create
      @post_management = PostManagement.new(post_management_params)
      @post_management.save
    end
  
    def update
      @post_management = PostManagement.find(params[:id])
      @post_management.update(post_management_params)
      end
    end
  
    def destroy
      @post_management = PostManagement.find(params[:id])
      @post_management.destroy
    end
  
    private
  
    def post_management_params
      params.require(:post_management).permit(:book_id, :spot_id)
    end
    
  end)
  end
  
end
