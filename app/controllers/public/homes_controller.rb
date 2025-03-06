class Public::HomesController < ApplicationController
  before_action :authenticate_user!, except: [:top, :about]

  def top
    @books = Book.all
    @books_new = @books.order(created_at: :desc).limit(4)
    @spots = Spot.all
    @spots_new = @spots.order(created_at: :desc).limit(4)
  end
    
end
