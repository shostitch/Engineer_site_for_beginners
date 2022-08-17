class User::PostCommentsController < ApplicationController

  def create
    @post = Post.find(params[:post_id])
    @post_comment = current_member.post_comments.new(post_comment_params)
    @post_comments = @post.post_comments.page(params[:page]).reverse_order
    @post_comment.post_id = @post.id
    if @post_comment.save
      render :post_comments, notice: 'コメント完了しました'
    end
  end


  def destroy
    @post = Post.find(params[:post_id])
    @post_comment = PostComment.find(params[:id])
    @post_comments = @post.post_comments.page(params[:page]).reverse_order
    if @post_comment.destroy
      render :post_comments, notice: 'コメントを削除しました'
    end
  end

  private

  def post_comment_params
    params.require(:post_comment).permit(:comment)
  end

end
