class Admin::PostsController < ApplicationController
  before_action :authenticate_admin!

  def index
    @posts = Post.all
  end

  def show
    @post = Post.find(params[:id])
    @member = @post.member
  end

  def edit
    @post = Post.find(params[:id])
    @member = @post.member
    @tag_list = @post.tags.pluck(:name).join(',')
    @post_status = @post.status == 'draft'
  end

  def update
    @post = Post.find(params[:id])
    tag_list = params[:post][:name].split(/[,、 　]/)
    if @post.update(post_params)
      @old_relations = PostTag.where(post_id: @post.id)
        @old_relations.each do |relation|
          relation.delete
        end
      @post.save_tag(tag_list)
      redirect_to admin_posts_path, notice: '更新完了しました'
    else
      render :edit
    end
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    redirect_to admin_member_path(@post.member_id), notice: '削除しました'
  end

  private

  def post_params
    params.require(:post).permit(:title,:content,:status)
  end
end
