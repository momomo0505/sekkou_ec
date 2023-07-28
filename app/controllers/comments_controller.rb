class CommentsController < ApplicationController
  def create
    @comment = Comment.new(comment_params)
    if @comment.save
      redirect_to item_path(@comment.item)
    else
      @item = @comment.item
      @comments = @item.comments.order(created_at: :desc)
      render "items/show"
    end
  end

  def show
    @item = Item.find(params[:id])
    @comments = @item.comments.order(created_at: :desc)
  end

  private
  def comment_params
    params.require(:comment).permit(:content).merge(user_id: current_user.id, item_id: params[:item_id])
  end

end

