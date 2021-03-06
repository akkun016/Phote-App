class PostsController < ApplicationController
  before_action :move_to_index, only: [:new, :create, :edit, :update]
  before_action :like_data
  before_action :set_users
  # before_action :post_item, except: [:index, :new, :create]

  def index
    @posts = Post.includes(:images, :user).order('created_at DESC')
    @comment = Comment.new
    @users = User.where.not(id: current_user.id).limit(5)
  end
  
  def new
    @post = Post.new
    @post.images.build
    @user = User.find(current_user.id)
  end

  def show
    @post = Post.find(params[:id])
    @comment = Comment.new
    @comments = @post.comments
    @comment_count = Comment.where(post_id: @post.id).count
  end
  
  def create
    @user = User.find(current_user.id)
    @post = Post.new(post_params)
    if @post.save
      redirect_to root_path
    else
      render :new
      flash.now[:alert] = "投稿に失敗しました"
    end
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    post = Post.find(params[:id])
    post.update(post_params)
    redirect_to root_path
  end


  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    redirect_to root_path
  end

  def tag
    @user = current_user
    @tag = Tag.find_by(name: params[:name])
    @posts = @tag.posts.order('created_at DESC')
    @tag_count = @posts.count
  end


  def all_posts
    @posts = Post.includes(:images).sort {|a,b| b.liked_users.count <=> a.liked_users.count}
  end

  private

  def post_params
    params.require(:post).permit(:content, :tag_ids, images_attributes: [:image]).merge(user_id: current_user.id)
  end

  def set_post
    @post = Post.find(params[:id]) 
  end

  def move_to_index
    redirect_to action: :index unless user_signed_in?
  end

  def like_data
    my_posts = Post.where(user_id: current_user.id).ids
    @likes = Like.where(post_id: my_posts)
  end

  def set_users
    @search_users = User.where.not(id: current_user.id)
  end
end
