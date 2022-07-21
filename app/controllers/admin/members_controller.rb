class Admin::MembersController < ApplicationController
  before_action :authenticate_admin!
  before_action :find_member,only: [:show,:edit,:update]

  def index
    @members = Member.all
  end

  def show
    @posts = @member.posts
  end

  def edit
  end

  def update
    if @member.update(member_params)
      redirect_to admin_member_path(@member.id), notice: '編集完了しました'
    else
      render :error_messages
    end
  end

  private

  def member_params
    params.require(:member).permit(:last_name,:first_name,:nickname,:introduction,:email,:is_active)
  end

  def find_member
    @member = Member.find(params[:id])
  end

end
