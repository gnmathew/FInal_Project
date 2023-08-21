class Admins::OrdersController < Admins::BaseController
  before_action :set_order, only: [:pay, :cancel]
  def index
    @orders = Order.includes(:offer)
    @total_orders = @orders.sum { |order| order.amount }
    @orders = @orders.page(params[:page]).per(5)
    @sub_total = @orders.sum { |order| order.amount }
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
end
