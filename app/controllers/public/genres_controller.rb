class Public::GenresController < ApplicationController

  def show
    @genre = Genre.find(params[:id])
    @books = @genre.books
  end
  
end
