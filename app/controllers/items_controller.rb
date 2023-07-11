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
    @item.destroy
  end
    redirect_to root_path
end

def edit
  if @item.user_id == current_user.id && @item.order.nil?
  else
    redirect_to root_path
  end
end

def update
  if @item.update(item_params)
    redirect_to item_path(@item)
  else
    render 'edit'
  end
end

private

def item_params
  params.require(:item).permit(:image, :name, :description, :category_id, :item_condition_id, :shipping_charge_id, :prefecture_id, :days_to_ship_id, :price).merge(user_id: current_user.id)
end

def set_item
  @item = Item.find(params[:id])
end
end
