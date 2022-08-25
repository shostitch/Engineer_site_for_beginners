class Admin::PostCommentsController < ApplicationController
  before_action :authenticate_admin!

  def destroy
    @post = Post.find(params[:post_id])
    @post_comment = PostComment.find(params[:id])
    @post_comments = @post.post_comments.page(params[:page]).reverse_order
    if @post_comment.destroy
      render :post_comments, notice: 'コメントを削除しました'
    end
  end

end
