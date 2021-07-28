class ItemsController < ApplicationController
  def index
    @items = Item.includes(:user)
  end
end
