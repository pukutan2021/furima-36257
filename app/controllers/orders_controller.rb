class OrdersController < ApplicationController
  before_action :authenticate_user!

  def index
    @item = Item.find(params[:item_id])
    @order_transaction = OrderTransaction.new
    if current_user == @item.user
      redirect_to root_path
    end
  end

  def create
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
