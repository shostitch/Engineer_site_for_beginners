class User::MembersController < ApplicationController
before_action :authenticate_member!
before_action :find_member,only: [:show,:edit,:update,:likes]

  def index
    @members = Member.all
  end

  def show
  end

  def edit
    if @member.full_name == "guest member"
      flash[:notice] = 'ゲストユーザーはプロフィール編集画面へ遷移できません。'
      redirect_to member_path(current_member)
    elsif current_member.id != @member.id
      redirect_to members_path
    end
  end

  def update
    if @member.update(member_params)
      flash[:notice] = '変更完了'
      redirect_to member_path(@member.id)
    else
      render :edit
    end
  end

  def check
  end

  def withdrawal
    current_member.update(is_active: false)
    reset_session
    redirect_to root_path
  end

  def likes
    @member = Member.find(params[:id])
    @likes = Like.where(member_id: @member.id)
  end

  private

  def member_params
    params.require(:member).permit(:last_name, :first_name, :nickname, :introduction, :start_date)
  end

  def find_member
    @member = Member.find(params[:id])
  end

end
