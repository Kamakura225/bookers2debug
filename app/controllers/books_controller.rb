class BooksController < ApplicationController
  before_action :ensure_correct_user, only: [:edit, :update ]
  def show
    @book = Book.find(params[:id])
    @new_book = Book.new
    @books = Book.includes(:user).all
    @post_comment = PostComment.new
  
    @user = @book.user
  end

  def index
    @books = Book.all
    @book = Book.new
   
  end

  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    if @book.save
      redirect_to book_path(@book), notice: "You have created book successfully."
    else
      @books = Book.all
      render :index
    end
  end

  def edit
    @book = Book.find(params[:id])
  end

  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
      redirect_to book_path(@book), notice: "You have updated book successfully."
    else
      render "edit"
    end
  end

  def delete
    @book = Book.find(params[:id])
    @book.destoy
    redirect_to books_path
  end

  def destroy
    book = Book.find(params[:id])
    book.destroy
    flash[:notice] = "Book was successfully destroy."
    redirect_to '/books'
  end
  
    
  private

  def book_params
    params.require(:book).permit(:title, :body)
  end

  def ensure_correct_user
    @book = Book.find(params[:id])
    unless @book.user == current_user
      redirect_to books_path
    end
  end


end
