class OrdersController < ApplicationController
  def index
    @order_transaction = OrderTransaction.new
    @item = Item.find(params[:item_id])
  end

  def create
    @item = Item.find(params[:item_id])
    @order_transaction = OrderTransaction.new(order_params)
    if @order_transaction.valid?
      @order_transaction.save
      redirect_to root_path
    else
      render :index
    end
  end

  private
  def order_params
    params.require(:order_transaction).permit(:postal_code, :prefecture_id, :city, :addresses, 
      :building, :phone_number).merge(user_id: current_user.id, item_id: params[:item_id])
  end
end
