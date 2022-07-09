class User::PostsController < ApplicationController
  before_action :authenticate_member!,except:[:index]
  before_action :find_post,only: [:show,:edit,:update,:destroy]

  def new
    @post = Post.new
    if current_member.full_name == 'guest member'
      redirect_to posts_path
    end
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
    @post_comment = PostComment.new
  end

  def edit
    if current_member.id != @post.member_id
      redirect_to posts_path
    end
  end

  def update
    @post.update(post_params)
    redirect_to post_path(@post.id)
  end

  def destroy
    @post.destroy
    redirect_to posts_path
  end


  private

  def  post_params
    params.require(:post).permit(:title, :content)
  end

  def find_post
    @post = Post.find(params[:id])
  end

end
