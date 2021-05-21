class ItemsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]

  def index
    @items = Item.order('created_at DESC')
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to root_path
    else
      render :new
    end
  end

  def show
    @item = Item.find(params[:id])
  end

  private

  def item_params
    params.require(:item).permit(:item_image, :item_name, :item_description, :item_category_id,
                                 :item_status_id, :item_shipping_fee_status_id, :prefecture_id,
                                 :item_days_to_ship_id, :item_price).merge(user_id: current_user.id)
  end
end
