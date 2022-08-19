class User::SearchesController < ApplicationController

  def search
	@model = params[:model]
	@content = params[:content]
	@method = params[:method]
	if @model == 'member'
	  @records = Member.search_for(@content, @method)
	  @records = @records.page(params[:page])
	else
	  @records = Post.published.search_for(@content, @method)
	  @records = @records.page(params[:page])
	end
  end

end
