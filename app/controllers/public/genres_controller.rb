class Public::GenresController < ApplicationController

  def show
    @genre = Genre.find(params[:id])
    books = @genre.books.includes(:bookmarks)

    if params[:new]
      @books = books.order(created_at: :desc).page(params[:page])
    elsif params[:old]
      @books = books.order(created_at: :asc).page(params[:page])
    elsif params[:bookmark]
      sorted_books = books.sort_by { |book| -book.bookmarks.size }
      @books = Kaminari.paginate_array(sorted_books).page(params[:page])
    else
      @books = books.page(params[:page])
    end

  end
  
end
