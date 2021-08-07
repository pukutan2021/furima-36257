class OrdersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_item, only: [:index, :create]
  before_action :order_confirmation, only: [:index, :create]

  def index
    @order_transaction = OrderTransaction.new    
  end

  def create
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

  def set_item
    @item = Item.find(params[:item_id])
  end

  def pay_item
    Payjp.api_key = ENV["PAYJP_SECRET_KEY"]  
      Payjp::Charge.create(
        amount: Item.find(params[:item_id]).price,
        card: order_params[:token],
        currency: 'jpy'
      )
  end

  def order_confirmation
    if current_user == @item.user || @item.order.present?
      redirect_to root_path
    end
  end

end
