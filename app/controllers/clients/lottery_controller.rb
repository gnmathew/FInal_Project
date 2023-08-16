class Clients::LotteryController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  def index
    @categories = Category.all
    @items = Item.where(status: 'active', state: 'starting', online_at: Time.current..)
    if params[:category_id].present?
      @items = @items.where(category_id: params[:category_id])
    end
  end

  def show
    @item = Item.find(params[:id])
    @bet = Bet.new
    @all_bet_count = @item.bets.where(batch_count: @item.batch_count).count
    @bet_percentage = (@all_bet_count.to_f / @item.minimum_bets) * 100
    @user_bets = current_user&.bets&.where(batch_count: @item.batch_count)

  end

  def create
    @bet_count = params[:bet][:bet_count].to_i
    if current_user.coins >= @bet_count
      @bet_count.times do
        @bet = Bet.new(bet_params)
        @bet.user = current_user
        @bet.batch_count = @bet.item.batch_count
        if @bet.save
          flash[:notice] = "You have successfully placed bets"
        else
          flash[:alert] = @bet.errors.full_messages.join(', ')
        end
      end
      redirect_to lottery_index_path
    else
      flash[:alert] = "You have insufficient balance"
      redirect_to lottery_index_path
    end
  end

  private

  def bet_params
    params.require(:bet).permit(:item_id)
  end
end

