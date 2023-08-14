class Clients::LotteryController < ApplicationController
  def index
    @categories = Category.all
    @items = Item.where(status: 'active', state: 'starting', online_at: Time.current..)
    if params[:category_id].present?
      @items = @items.where(category_id: params[:category_id])
    end
  end
end

