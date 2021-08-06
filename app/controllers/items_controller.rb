class ItemsController < ApplicationController
  before_action :set_item, only: [:edit, :update, :destroy, :show]
  before_action :authenticate_user!, only: [:new, :create, :edit, :destroy]
  before_action :contributor_confirmation, only: [:edit, :update, :destroy]

  def index
    @items = Item.includes(:user).order('created_at DESC')
    @order_transaction = OrderTransaction.new(params[:item_id])
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
    @order_transaction = OrderTransaction.new(params[:item_id])
  end

  def edit
    @order_transaction = OrderTransaction.new(params[:item_id])
    if @item.order.present? 
      redirect_to root_path
    end
  end

  def update
    if @item.update(item_params)
      redirect_to item_path(@item)
    else
      render :edit
    end
  end

  def destroy
    @item.destroy
    redirect_to root_path
  end

  private

  def item_params
    params.require(:item).permit(:name, :info, :category_id, :sales_status_id, :shipping_fee_status_id,
      :prefecture_id, :scheduled_delivery_id, :price, :image, :order_transaction).merge(user_id: current_user.id)
  end

  def set_item
    @item = Item.find(params[:id])
  end

  def contributor_confirmation
    redirect_to root_path unless current_user == @item.user
  end
end
