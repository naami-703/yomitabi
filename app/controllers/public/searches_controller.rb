class Public::SearchesController < ApplicationController
  before_action :authenticate_user!

  def index
    @range = params[:range]
    @word = params[:word]

    if @range == "user"
      @users = User.looks(params[:search], params[:word])
    elsif @range == "book"
      @books = Book.looks(params[:search], params[:word])
    else
      @spots = Spot.looks(params[:search], params[:word])
    end
  end

end
