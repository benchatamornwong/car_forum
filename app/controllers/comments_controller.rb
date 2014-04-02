class CommentsController < ApplicationController
  
  def new
    @post = Post.find(params[:post_id])
    @comment = Comment.new
  end

  def create
  	@comment = current_user.comments.build(comment_params)
    @post = Post.find(params[:post_id])
    @comments = @post.comments
    @comment.post = @post
  	if current_user && @comment.save
      @post.update_attributes(updated_at: Time.now)
      respond_to do |format|
        format.html { redirect_to :back }
        format.js
      end
    else
      render 'static_pages/home'
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    @post = Post.find(params[:post_id])
    @comments = @post.comments
    @comment.destroy
    respond_to do |format|
      format.html { redirect_to :back }
      format.js
    end
  end

  def show
    @comment = Comment.find(params[:id])
  end

  def update
    @comment = Comment.find(params[:id])
    @post = @comment.post
    @comments = @post.comments
    if @comment.update_attributes(comment_params)
      @post.update_attributes(latest_interaction: Time.now)
      respond_to do |format|
        format.html { redirect_to :back }
        format.js
      end
    else
      respond_to do |format|
        format.html { redirect_to :back }
        format.js
      end
    end
  end

  def upvote
    @comment = Comment.find(params[:id])
    @post = @comment.post
    @comments = @comment.post.comments
    if @comment.liked_by current_user
      respond_to do |format|
        format.html { redirect_to :back }
        format.js
      end
    end
  end

  def downvote
    @comment = Comment.find(params[:id])
    @post = @comment.post
    @comments = @comment.post.comments
    if @comment.disliked_by current_user
      respond_to do |format|
        format.html { redirect_to :back }
        format.js
      end
    end
  end

  def unupvote
    @comment = Comment.find(params[:id])
    @post = @comment.post
    @comments = @comment.post.comments
    if @comment.unliked_by current_user
      respond_to do |format|
        format.html { redirect_to :back }
        format.js
      end
    end
  end

  def undownvote
    @comment = Comment.find(params[:id])
    @post = @comment.post
    @comments = @comment.post.comments
    if @comment.undisliked_by current_user
      respond_to do |format|
        format.html { redirect_to :back }
        format.js
      end
    end
  end

	private

  	def comment_params
  		params.require(:comment).permit(:content , :post_id)
  	end
end
