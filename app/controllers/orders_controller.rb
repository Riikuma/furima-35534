class OrdersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_item
  before_action :item_seller?
  before_action :item_soldout?

  def index
    @order = Order.new
  end

  def create
    @order = Order.new(order_params)
    if @order.valid?
      pay_item
      @order.save
      redirect_to root_path
    else
      render :index
    end
  end

  private

  def order_params
    params.require(:order).permit(:buyer_postal_code, :prefecture_id, :buyer_city, :buyer_address, :buyer_building,
                                  :buyer_phone_number).merge(token: params[:token], user_id: current_user.id, item_id: @item.id)
  end

  def set_item
    @item = Item.find(params[:item_id])
  end

  def pay_item
    Payjp.api_key = ENV['PAYJP_SECRET_KEY'] # PAY.JPテスト秘密鍵
    Payjp::Charge.create(
      amount: @item.item_price, # 商品の値段
      card: order_params[:token], # カードトークン
      currency: 'jpy' # 通貨の種類（日本円）
    )
  end

  def item_seller?
    if current_user.id == @item.user_id
      redirect_to root_path
    end
  end

  def item_soldout?
    if @item.purchase_record != nil
      redirect_to root_path
    end
  end
end
