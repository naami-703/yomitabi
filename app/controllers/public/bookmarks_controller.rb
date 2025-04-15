class Public::BookmarksController < Public::ApplicationController
  
  def create
    @book = Book.find(params[:book_id])
    bookmark = current_user.bookmarks.new(book_id: @book.id)
    bookmark.save
  end

  def destroy
    @book = Book.find(params[:book_id])
    bookmark = current_user.bookmarks.find_by(book_id: @book.id)
    bookmark.destroy
  end

end
