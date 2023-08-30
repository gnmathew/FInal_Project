class Clients::ProfilesController < ApplicationController
  before_action :authenticate_user!
  def show
    if params[:order_history].present?
      @order_histories = current_user.orders.page(params[:page]).per(2)
    end
    if params[:lottery_history].present?
      @lottery_histories = current_user.bets.page(params[:page]).per(2)
    end
    if params[:winning_history].present?
      @winning_histories = current_user.winners.page(params[:page]).per(2)
    end
    if params[:invite_history].present?
      @invite_histories = current_user.children.page(params[:page])&.per(2)
    end

  end

  def edit
    @client = current_user
  end

  def update
    @client = current_user

    if @client.update(update_without_password_params)
      redirect_to profile_path, notice: "Successfully Updated"
    else
      @client.update(update_with_password_params)
      redirect_to profile_path, notice: "Successfully Updated"
    end
  end

  def cancel_order
    @order = current_user.orders.where(state: [:submitted, :pending]).find(params[:id])
    if @order.may_cancel?
      @order.cancel!
      flash[:notice] = "You have successfully cancelled your order"
    else
      flash[:alert] = "Failed to cancel your order!"
    end
    redirect_to profile_path
  end

  private

  def update_without_password_params
    params.require(:user).permit(:phone_number, :username, :image)
  end

  def update_with_password_params
    params.require(:user).permit(:username, :email, :phone_number, :image, :password)
  end

end
