class OrdersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_item

  def index
    @order = Order.new
  end

  def create
    @order = Order.new(order_params)
    if @order.valid?
      @order.save
      redirect_to root_path
    else
      render :index
    end
  end

  private

  def order_params
    params.require(:order).permit(:buyer_postal_code, :prefecture, :buyer_city, :buyer_address, :buyer_building, :buyer_phone_number).merge(user_id: current_user.id, item_id: @item.id)
  end

  def set_item
    @item = Item.find(params[:item_id])
  end
end
