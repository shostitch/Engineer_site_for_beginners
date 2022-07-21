class User::PostsController < ApplicationController
  before_action :authenticate_member!
  before_action :find_post,only: [:show,:edit,:update,:destroy]

  def new
    @post = Post.new
    if current_member.guest_member
      redirect_to posts_path, notice: 'ゲストメンバーは投稿ができません'
    end
  end

  def create
    @post = current_member.posts.new(post_params)
    tag_list = params[:post][:name].split(/[,、 　]/)#全角半角スペース込みもしものため
    if @post.save
      @post.save_tag(tag_list)
      redirect_to  posts_path, notice: '投稿しました。'
    else
      render :error_messages
    end
  end

  def confirm
    @posts = current_member.posts.draft.reverse_order
  end

  def index
    @posts = Post.published.reverse_order
    @posts = @posts.where('title LIKE ?', "%#{params[:search]}%") if params[:search].present?
  end

  def search_tag
    @tag_lists=Tag.all
    @tag=Tag.find(params[:tag_id])
    @posts=@tag.posts.published
  end

  def show
    @post_comment = PostComment.new
    @post_tags = @post.tags
  end

  def edit
    if current_member.id != @post.member_id
      redirect_to posts_path, notice: '投稿したメンバーでないと編集はできません'
    end
    @tag_list = @post.tags.pluck(:name).join(',')
    @post_status = @post.status == 'draft'
  end

  def update
    tag_list=params[:post][:name].split(/[,、 　]/)
    if @post.update(post_params)
      @old_relations=PostTag.where(post_id: @post.id)
      @old_relations.each do |relation|
        relation.delete
      end
      @post.save_tag(tag_list)
      redirect_to post_path(@post.id), notice: '更新完了しました'
    else
      render :error_messages
    end
  end

  def destroy
    if @post.destroy
      redirect_to posts_path, notice: '削除完了しました'
    end
  end

  def sort
    selection = params[:keyword]
    @posts = Post.sort(selection)
  end


  private

  def  post_params
    params.require(:post).permit(:title, :content,:status)
  end

  def find_post
    @post = Post.find(params[:id])
  end

end
