class User::MembersController < ApplicationController
before_action :authenticate_member!
before_action :find_member,only: [:show,:edit,:update,:likes]

  def index
    @members = Member.all
  end

  def show
    @posts = @member.posts
  end

  def edit
    if @member.guest_member
      redirect_to member_path(current_member), notice: 'ゲストメンバーはプロフィール編集画面へ遷移できません。'
    elsif current_member.id != @member.id
      redirect_to members_path
    end
  end

  def update
    if @member.update(member_params)
      redirect_to member_path(@member.id), notice: '変更完了しました'
    else
      render :error_messages
    end
  end

  def check
  end

  def withdrawal
    current_member.update(is_active: false)
    reset_session
    redirect_to root_path, notice: '退会しました'
  end

  def likes
    @member = Member.find(params[:id])
    @likes = Like.where(member_id: @member.id)
  end

  private

  def member_params
    params.require(:member).permit(:last_name, :first_name, :nickname, :introduction, :start_date, :profile_image)
  end

  def find_member
    @member = Member.find(params[:id])
  end

end
