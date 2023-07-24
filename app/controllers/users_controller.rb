class UsersController < ApplicationController
 
  def show
    @user = User.find(params[:id])
  end

  def create
    @user = User.new(user_params)
    if @user.save
      @user.create_cart
      # ...
    else
      # ...
    end
  end

  def remove_item
    @item = Item.find(params[:item_id]) # :id を :item_id に変更
    current_user.cart.items.delete(@item)
      
    redirect_to user_path(current_user) # リダイレクト先が明示的になるよう修正
  end
end
