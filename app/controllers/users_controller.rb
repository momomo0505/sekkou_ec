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

end
