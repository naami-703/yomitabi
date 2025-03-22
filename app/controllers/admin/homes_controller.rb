class Admin::HomesController < ApplicationController
  before_action :authenticate_admin!

  def top 
    @books = Book.page(params[:page])
    @books_new = @books.order(created_at: :desc).limit(4)
    @spots = Spot.page(params[:page])
    @spots_new = @spots.order(created_at: :desc).limit(4)
  end
  
end
