class CommentsController < ApplicationController
  
  def new
    @post = Post.find(params[:post_id])
    @comment = Comment.new
  end

  def create
  	@comment = current_user.comments.build(comment_params)
    @post = Post.find(params[:post_id])
    @comment.post = @post
  	if current_user && @comment.save
      @post.update_attributes(updated_at: Time.now)
      flash[:success] = "Comment submitted!"
      redirect_to board_post_path(@post.board, @post)
    else
      render 'static_pages/home'
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy
    flash[:success] = "Comment deleted."
    redirect_to board_post_path(@comment.post.board, @comment.post)
  end

  def show
    @comment = Comment.find(params[:id])
  end

  def update
    @post = @comment.post
    if @comment.update_attributes(comment_params)
      @post.update_attributes(latest_interaction: Time.now)
      flash[:success] = "Comment updated"
      redirect_to board_post_path(@comment.post.board, @comment.post)
    else
      redirect_to board_post_path(@comment.post.board, @comment.post)
    end
  end

  def upvote
    @comment = Comment.find(params[:id])
    @post = @comment.post
    if @comment.liked_by current_user
      redirect_to board_post_path(@post.board, @post)
    end
  end

  def downvote
    @comment = Comment.find(params[:id])
    @post = @comment.post
    if @comment.downvote_from current_user
      redirect_to board_post_path(@post.board, @post)
    end
  end

	private

  	def comment_params
  		params.require(:comment).permit(:content , :post_id)
  	end
end
