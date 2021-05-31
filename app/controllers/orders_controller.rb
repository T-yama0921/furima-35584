class OrdersController < ApplicationController
  before_action :authenticate_user!, only: [:index, :create]

  def index
    @item = Item.find(params[:item_id])
    if @item.user.id == current_user.id
      return redirect_to root_path
    end
    @order_address = OrderAddress.new
  end

  def create
    @item = Item.find(params[:item_id])
    @order_address = OrderAddress.new(order_params)
    if @order_address.valid?
      @order_address.save
      return redirect_to root_path
    else
      render :index
    end
  end

  private

  def order_params
    params.require(:order_address).permit(
      :postal_code,
      :shipping_area_id,
      :city,
      :house_number,
      :building_name,
      :phone_number,
      :order_id,
    ).merge(
      user_id: current_user.id,
      item_id: @item.id
    )
  end

end
