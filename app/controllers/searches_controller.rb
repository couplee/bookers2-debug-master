class SearchesController < ApplicationController
  def search
    # @user = User.find(params[:id])
    # @book = Book.find(params[:id])
    @range = params[:range]
    @searches = params[:search]
    @word = params[:word]

    if @range == "User"
      @user = User.search(@searches,@word)
    else
      @book = Book.search(@searches,@word)
    end
    p "@user"
    p @user
  end
end


