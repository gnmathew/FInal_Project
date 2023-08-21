class Clients::ShopController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]

  def index
    @offers = Offer.where(status: "active")
  end

  def show
    @offer = Offer.find(params[:id])
    @order = Order.new
  end

  def create

    @offer = Offer.find_by(id: params[:order][:offer_id])
    @order = Order.new(offer_id: @offer.id)
    @order.genre = "increase"
    @order.amount = @offer.amount
    @order.coin = @offer.coin
    @order.user = current_user
    if @order.save
      flash[:notice] = "You have successfully purchased"
    else
      flash[:alert] = @order.errors.full_messages.join(', ')
    end
    redirect_to shop_index_path
  end

end