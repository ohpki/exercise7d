class BooksController < ApplicationController

  def new
   @book = Book.new
  end

  def show
    @book = Book.find(params[:id])
    @user = @book.user
    @book_comment = BookComment.new
    @book_tags = @book.tags
  end

  def index
    @books = Book.all
    @book = Book.new
    @tag_list=Tag.all
  end

  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    tag_list = params[:book][:name].delete(' ').delete('　').split(',')
    if @book.save
    @book.save_tags(tag_list)
      redirect_to book_path(@book.id), notice: "You have created book successfully."
    else
      @books = Book.all

      render 'index'
    end
  end


  def edit
    @book = Book.find(params[:id])
    @user = @book.user
    @tag_list = @post.tags.pluck(:tag_name).join(',')
    if @user == current_user
      render :edit
    else
      redirect_to books_path
    end
  end

  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
      redirect_to book_path(@book), notice: "You have updated book successfully."
    else
      render "edit"
    end
  end

  def destroy
    @book = Book.find(params[:id])
    @book.destroy
    redirect_to books_path
  end

  def search
    selection = params[:keyword]
    @books = Book.sort(selection)
    @book = Book.new
    render :index

  end
  def search_tag
    #検索結果画面でもタグ一覧表示
    @tag_list=Tag.all
    @tag=Tag.find(params[:tag_id])
    @books=@tag.books.page(params[:page]).per(10)
    render :index
  end



  private

  def book_params
    params.require(:book).permit(:title, :body, :rate)
  end


end
