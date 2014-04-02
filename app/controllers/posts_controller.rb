class PostsController < ApplicationController
  before_action :signed_in_user, only: [:create, :destroy]

  def index
    if params[:tag]
      @posts = Post.tagged_with(params[:tag])
    else
      @posts = Post.all
    end
  end

  def new
    @board = Board.find(params[:board_id])
    @post = Post.new
    @post_attachment = @post.post_attachments.build
  end

  def show
    @post = Post.find(params[:id])
    @comments = @post.comments.paginate(:page => params[:page], :per_page => 15)
    if @post.post_attachments
      @post_attachments = @post.post_attachments.all
    end
  end

  def create
  	@post = current_user.posts.build(post_params)
    @board = Board.find(params[:board_id])
    @post.board = @board
    
    if current_user && @post.save
      if params[:post_attachments] != nil
        params[:post_attachments]['avatar'].each do |a|
          @post_attachment = @post.post_attachments.create!(:avatar => a, :post_id => @post.id)
        end
      end
      flash[:success] = "Post created!"
      redirect_to board_post_path(@board, @post)
    else
      render 'static_pages/home'
    end
  end

  def destroy
    @post = Post.find(params[:id])
    @board = @post.board
    @post.destroy
    flash[:success] = "Post deleted."
    redirect_to :back
  end

  def update
    @post = Post.find(params[:id])
    @board = @post.board
    if @post.update_attributes(post_params)
      @post.update_attributes(latest_interaction: Time.now)
      @post.update_attributes(latest_edit: Time.now)
      if params[:post_attachments] != nil
        params[:post_attachments]['avatar'].each do |a|
          @post_attachment = @post.post_attachments.create!(:avatar => a, :post_id => @post.id)
        end
      end
      flash[:success] = "Post updated"
      redirect_to board_post_path(@board, @post)
    else
      render 'edit'
    end
  end

  def edit
    @post = Post.find(params[:id])
    @post_attachments = @post.post_attachments
  end

  def search
    if params[:search]
      @posts = Post.search(params[:search]).paginate(page: params[:page])
    end
  end

  def upvote
    @post = Post.find(params[:id])
    if @post.liked_by current_user
      redirect_to :back
    end
  end

  def downvote
    @post = Post.find(params[:id])
    if @post.disliked_by current_user
      redirect_to :back
    end
  end

  def unupvote
    @post = Post.find(params[:id])
    if @post.unliked_by current_user
      redirect_to :back
    end
  end

  def undownvote
    @post = Post.find(params[:id])
    if @post.undisliked_by current_user
      redirect_to :back
    end
  end

  private

  	def post_params
  		params.require(:post).permit(:title, :content , :board_id, :tag_list, post_attachments_attributes: [:id, :post_id, :avatar])
  	end
end