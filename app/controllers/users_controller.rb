class UsersController < ApplicationController
  before_action :signed_in_user, only: [:index, :edit, :update, :destroy]
  before_action :correct_user,   only: [:edit, :update]
  before_action :admin_user,     only: :destroy

  def index
    if params[:users_search]
      @users = User.search(params[:users_search]).order("name").paginate(page: params[:page])
    else
      @users = User.order("name").paginate(page: params[:page])
    end
  end

  def show
  	@user = User.find(params[:id])
    @posts = @user.posts.paginate(page: params[:post_page], per_page: 10)
    @comments = @user.comments.paginate(page: params[:comment_page], per_page: 10).order('updated_at DESC')
  end

  def new
  	@user = User.new
  end

  def create
  	@user = User.new(user_params)
  	if @user.save
      sign_in @user
      redirect_to @user
    else
      render 'new'
    end
  end

  def update
    if @user.update_attributes(user_params)
      redirect_to @user
    else
      render 'edit'
    end
  end
  
  def destroy
    User.find(params[:id]).destroy
    redirect_to users_url
  end

  def admin
    @user = User.find(params[:id])
    @user.toggle!(:admin)
    redirect_to :back
  end

  private
  	def user_params
  		params.require(:user).permit(:name, :email, :password,
  			:password_confirmation, :avatar)
  	end

    # Before filters

    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_url) unless current_user?(@user)
    end

    def admin_user
      redirect_to(root_url) unless current_user.admin?
    end
end
