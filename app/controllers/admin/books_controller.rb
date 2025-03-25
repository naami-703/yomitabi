class Admin::BooksController < ApplicationController
  before_action :authenticate_admin!

  def index 
    books = Book.all
    @books = books.order(created_at: :desc).page(params[:page]).per(12)
  end

  def edit
    @book = Book.find(params[:id])
  end

  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
      redirect_to admin_books_path, notice: "書籍情報を更新しました。"
    else
      render "edit"
    end
  end

  def destroy
    @book = Book.find(params[:id])
    @book.destroy
    redirect_to admin_books_path
  end

  private

  def book_params
    params.require(:book).permit(:title, :book_image)
  end
  
end
