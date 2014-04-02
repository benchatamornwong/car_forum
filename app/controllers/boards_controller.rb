class BoardsController < ApplicationController
  
  def index
    @boards = Board.paginate(page: params[:page])
  end

  def new
    @board = Board.new
  end

  def show
  	@board = Board.find(params[:id])
  	@posts = @board.posts.paginate(page: params[:page])
  end

  def create
    @board = Board.new(board_params)
    if @board.save
      flash[:success] = "Board created!"
      redirect_to :back
    else
      render 'new'
    end
  end

  def edit
    @board = Board.find(params[:id])
  end

  def update
    @board = Board.find(params[:id])
    if @board.update_attributes(board_params)
      flash[:success] = "Board updated"
      redirect_to :back
    else
      render 'edit'
    end
  end

  def destroy
    Board.find(params[:id]).destroy
    flash[:success] = "Board deleted."
    redirect_to :back
  end

  private
    def board_params
      params.require(:board).permit(:title)
    end
end
