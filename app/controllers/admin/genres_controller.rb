class Admin::GenresController < ApplicationController
  before_action :authenticate_admin!

  def index 
    @genres = Genre.all
    @genre = Genre.new
  end

  def create
    @genre = Genre.new(genre_params)
    if @genre.save
      redirect_to admin_genres_path, notice: "ジャンルを新規登録しました。"
    else
      render 'index'
    end
  end

  private

  def genre_params
    params.require(:genre).permit(:name)
  end
  
end

