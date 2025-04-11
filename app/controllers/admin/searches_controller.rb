class Admin::SearchesController < ApplicationController
  before_action :authenticate_admin!

  def index
    @range = params[:range]
    @word = params[:word]

    if @range == "user"
      @users = User.looks(params[:search], params[:word]).page(params[:page])
    elsif @range == "book"
      @books = Book.looks(params[:search], params[:word]).page(params[:page])
    else
      @spots = Spot.looks(params[:search], params[:word]).page(params[:page])
    end
  end


end
