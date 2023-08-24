class Admins::OrdersController < Admins::BaseController
  before_action :set_order, except: [:index, :new, :create]
  before_action :set_user, only: [:new, :create]
  def index
    @orders = Order.includes(:offer)
    @total_orders = @orders.sum { |order| order.amount }
    @orders = @orders.page(params[:page]).per(5)
    @sub_total = @orders.sum { |order| order.amount }
  end

  def new
    @order = Order.new
  end

  def create
    @order = Order.new(params.require(:order).permit(:coin, :remarks))
    @order.genre = params[:genre]
    @order.user = @client
    if @order.save
      if @order.may_pay?
        @order.pay!
      else
        flash[:alert] = @order.errors.full_messages.join(', ')
        redirect_to user_new_genre_order_path
      end
      flash[:notice] = "Paid successfully"
    else
      flash[:alert] = @order.errors.full_messages.join(', ')
    end
    redirect_to user_new_genre_order_path
  end

  def pay
    if @order.pay!
      redirect_to orders_path, notice: 'Order was successfully paid.'
    else
      redirect_to orders_path, alert: 'Unable to pay the order.'
    end
  end

  def cancel
    if @order.cancel!
      redirect_to orders_path, notice: 'Order was successfully cancelled.'
    else
      redirect_to orders_path, alert: 'Unable to cancel the order.'
    end
  end

    private

    def set_order
      @order = Order.find(params[:id])
    end

  def set_user
    @client = User.client.find(params[:user_id])
  end
end
