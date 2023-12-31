class ItemsController < ApplicationController
  before_action :authenticate_user! , except: [:index , :show]
  before_action :set_item, only: [:edit, :update, :show, :destroy]

  def new 
    @item = Item.new
  end

  def index
    @items = Item.includes(:user).order("created_at DESC")
  end

def create
  @item = Item.new(item_params)
  if @item.save
    redirect_to root_path
  else
    render :new
  end
end

def destroy
if @item.user_id == current_user.id
  @item.cart_items.destroy_all 
  @item.comments.destroy_all
  @item.destroy
  redirect_to root_path
else
  redirect_to root_path, notice: "You are not authorized to delete this item."
end
end

def edit
  unless @item.user_id == current_user.id && @item.order.nil?
    redirect_to root_path, notice: "You are not authorized to edit this item."
  end
end

def update
  if @item.user_id == current_user.id
    if @item.update(item_params)
      redirect_to item_path(@item)
    else
      render 'edit'
    end
  else
    redirect_to root_path, notice: "You are not authorized to update this item."
  end
end

def add_to_cart
  @item = Item.find(params[:id])
  unless current_user.cart.items.include?(@item)
    current_user.cart.cart_items.create(item: @item)
  end
  redirect_to user_path(current_user)
end

def show
  @item = Item.find(params[:id])
  @comments = @item.comments.order(created_at: :desc)
  @comment = Comment.new
end

private

def item_params
  params.require(:item).permit(:name, :description, :category_id, :item_condition_id, :shipping_charge_id, :prefecture_id, :days_to_ship_id, :price, {images: []}).merge(user_id: current_user.id)
end

def set_item
  @item = Item.find(params[:id])
end
end
