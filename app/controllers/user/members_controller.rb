class User::MembersController < ApplicationController
before_action :find_member,only: [:show,:edit,:update]

  def index
    @members = Member.all
  end

  def show
  end

  def edit
    if current_member.id != @member.id
      redirect_to members_path
    end
  end

  def update
    @member.update(member_params)
    redirect_to member_path(@member.id)
  end

  def check
  end

  def withdrawal
    current_member.update(is_active: false)
    reset_session
    redirect_to root_path
  end

  private

  def member_params
    params.require(:member).permit(:last_name, :first_name, :nickname, :introduction)
  end

  def find_member
    @member = Member.find(params[:id])
  end

end
