class User::PostsController < ApplicationController
  before_action :correct_member,only: [:edit]

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.member_id = current_member.id
    if @post.save
      redirect_to  posts_path
    else
      render :new
    end
  end

  def index
    @posts = Post.all
  end

  def show
    @post = Post.find(params[:id])
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])
    @post.update(post_params)
    redirect_to post_path(@post.id)
  end

  def question
  end


  private

  def  post_params
    params.require(:post).permit(:title, :content)
  end

  def correct_member
    @post = Post.find(params[:id])
    if current_member.id != @post.member_id
      redirect_to posts_path
    end
  end

end
