class User::LikesController < ApplicationController

  def create
    post = Post.find(params[:post_id])
    like = current_member.likes.new(post_id: post.id)
    like.save
    redirect_to request.referer
  end

  def destroy
    post = Post.find(params[:post_id])
    like = current_member.likes.find_by(post_id: post.id)
    like.destroy
    redirect_to request.referer
  end
end
