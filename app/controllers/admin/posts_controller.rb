class Admin::PostsController < ApplicationController
  before_action :authenticate_admin!
  before_action :find_post,only: [:show,:edit,:update,:destroy]

  def index
    @posts = Post.page(params[:page]).reverse_order
  end

  def show
    @member = @post.member
    @post_comments = @post.post_comments.page(params[:page]).reverse_order
  end

  def edit
    @member = @post.member
    @tag_list = @post.tags.pluck(:tag_name).join(',')
    @post_status = @post.status == 'draft'
  end

  def update
    tag_list = params[:post][:tag_name].split(/[,]/)
    if @post.update(post_params)
      @old_relations = PostTag.where(post_id: @post.id)
        @old_relations.each do |relation|
          relation.delete
        end
      @post.save_tag(tag_list)
      redirect_to admin_post_path(@post.id), notice: '更新完了しました'
    else
      render :error_messages
    end
  end

  def destroy
    @post.destroy
    redirect_to admin_member_path(@post.member_id), notice: '削除しました'
  end

  private

  def post_params
    params.require(:post).permit(:title,:content,:status)
  end

  def find_post
    @post = Post.find(params[:id])
  end

end
