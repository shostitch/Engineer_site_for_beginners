class User::MembersController < ApplicationController
before_action :correct_member,only: [:edit,:update]

  def index
    @members = Member.all
  end

  def show
    @member = Member.find(params[:id])
  end

  def edit
    @member = Member.find(params[:id])
  end

  def update
    @member = Member.find(params[:id])
    @member.update(member_params)
    redirect_to member_path(@member.id)
  end

  def check
  end

  private

  def member_params
    params.require(:member).permit(:last_name, :first_name, :nickname, :introduction)
  end

  def correct_member
    @member = Member.find(params[:id])
    if current_member.id != @member.id
      redirect_to members_path
    end
  end

end
