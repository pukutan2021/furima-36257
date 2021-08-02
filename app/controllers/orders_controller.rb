class OrdersController < ApplicationController
  def index
    @order_transaction = OrderTransaction.new
  end

  def create
    @order_transaction = OrderTransaction.new(orders_params)
    if @order_transaction.valid?
      @order_transaction.save
      redirect_to root_path
    else
      render :index
    end
  end

  private
  def orders_params
    params.require(:order_transaction).permit(:postal_code, :prefecture_id, :city, :addresses, 
      :building, :phone_number).merge(user_id: current_user.id)
  end
end
