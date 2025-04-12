class Admin::HomesController < ApplicationController
  before_action :authenticate_admin!

  def top 
    books = Book.all
    @books = books.order(created_at: :desc).page(params[:page]).per(12)
    @books_new = @books.order(created_at: :desc).limit(3)
    spots = Spot.all
    @spots = spots.order(created_at: :desc).page(params[:page]).per(12)
    @spots_new = @spots.order(created_at: :desc).limit(3)
  end
  
end
