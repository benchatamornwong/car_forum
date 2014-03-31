class StaticPagesController < ApplicationController
  def home
  	@post = current_user.posts.build if signed_in?
  end

  def tags
    @tag_cloud = Post.tag_counts.all.take(50);
    if params[:tags_search]
      @tags = Post.tag_counts.where('name LIKE ?', "%#{params[:tags_search]}%")
    else
      @tags = Post.tag_counts.all
    end
  end
end