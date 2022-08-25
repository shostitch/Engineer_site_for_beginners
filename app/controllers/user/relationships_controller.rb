class User::RelationshipsController < ApplicationController
  before_action :authenticate_member!

  def create
    @member = Member.find(params[:member_id])
    current_member.follow(params[:member_id])
    render :follow_button
  end

  def destroy
    @member = Member.find(params[:member_id])
    current_member.unfollow(params[:member_id])
    render :follow_button
  end

  def followings
    @member = Member.find(params[:member_id])
    @members = @member.followings
  end

  def followers
    @member = Member.find(params[:member_id])
    @members = @member.followers
  end
end
