class PostsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_post, only: [:show, :edit, :update, :destroy]
  before_action :check_access, only: [:edit, :update, :destroy]

  def index
    @posts = Post.all
  end

  def new
    @post = current_user.posts.build
  end

  def create
    @post = current_user.posts.build(post_params)

    if @post.save
      flash[:success] = 'Your post has been created!'
      redirect_to root_path
    else
      flash[:alert] = 'Your new post couldn\'t be created!  Please check the form.'
      render :new
    end
  end

  def show
  end

  def edit
  end

  def update
    if @post.update(post_params)
      flash[:success] = 'Post updated.'
      redirect_to post_path(@post)
    else
      flash[:alert] = 'Update failed. Please check the form.'
      render :edit
    end
  end

  def destroy
    @post.destroy
    flash[:success] = 'Your post has been deleted.'
    redirect_to root_path
  end

  private

  def set_post
    @post = Post.find(params[:id])
  end

  def post_params
    params.require(:post).permit(:image, :caption)
  end

  def check_access
    return if current_user == @post.user
    flash[:alert] = 'That post doesn\'t belong to you!'
    redirect_to root_path
  end
end
