class User::SearchesController < ApplicationController
  before_action :authenticate_member!

  def search
	@model = params[:model]
	@content = params[:content]
	@method = params[:method]
	if @model == 'member'
	  @records = Member.search_for(@content, @method)
	else
	  @records = Post.search_for(@content, @method)
	end
  end

end
