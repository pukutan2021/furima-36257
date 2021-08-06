class OrdersController < ApplicationController
  before_action :authenticate_user!

  def index
    @order_transaction = OrderTransaction.new
    @item = Item.find(params[:item_id])
    if current_user == @item.user || @item.order.present?
      redirect_to root_path
    end
  end

  def create
    @item = Item.find(params[:item_id])
    @order_transaction = OrderTransaction.new(order_params)
    if @order_transaction.valid?
      pay_item
      @order_transaction.save
      redirect_to root_path
    else
      render :index
    end
  end

  private
  def order_params
    params.require(:order_transaction).permit(:postal_code, :prefecture_id, 
      :city, :addresses,:building, :phone_number).merge(user_id: 
        current_user.id, item_id: params[:item_id], token: params[:token])
  end

  def pay_item
    Payjp.api_key = ENV["PAYJP_SECRET_KEY"]  
      Payjp::Charge.create(
        amount: Item.find(params[:item_id]).price,
        card: order_params[:token],
        currency: 'jpy'
      )
  end

end
