class PostCommentsController < ApplicationController
  def create
    @book = Book.find(params[:book_id])
    @post_comment = current_user.post_comments.new(post_comment_params)
    @post_comment.book_id = @book.id
    if @post_comment.save
      # redirect_to book_path(@book.id)
    else
      @user = @book.user
      @new_book = Book.new
      # render "books/show"
    end
  end
  
  def destroy
    @book = Book.find(params[:book_id])
    # @post_comment_id = @book.id
    # @post_comment = @book.post_comments.find(params[:id])
    PostComment.find_by(id: params[:id], book_id: params[:book_id]).destroy
    # redirect_to book_path(params[:book_id])
  end
  
  private

  def post_comment_params
    params.require(:post_comment).permit(:comment)
  end
end
