class Admins::WinnersController < Admins::BaseController
  def index
    @winners = Winner.all

    if params[:serial_number].present?
      @winners = @winners.where(serial_number: params[:serial_number])
    end

    if params[:email].present?
      @winners = @winners.joins(:user).where("users.email LIKE ?", "%#{params[:email]}%")
    end

    if params[:state].present?
      @winners = @winners.where(state: params[:state])
    end

    if params[:start_date].present?
      @winners = @winners.where("created_at >= ?", params[:start_date])
    end

    if params[:end_date].present?
      @winners = @winners.where("created_at <= ?", params[:end_date])
    end
  end

  def claim
    if @winner.claim!
      redirect_to winners_path, notice: 'Winner, successfully claimed.'
    else
      redirect_to winners_path, alert: 'Unable to claim.'
    end

  end

  def submit
    if @winner.submit!
      redirect_to winners_path, notice: 'Submit successfully.'
    else
      redirect_to winners_path, alert: 'Unable to submit.'
    end

  end

  def pay
    if @winner.pay!
      redirect_to winners_path, notice: 'Paid successfully.'
    else
      redirect_to winners_path, alert: 'Unable to pay.'
    end

  end

  def ship
    if @winner.ship!
      redirect_to winners_path, notice: 'Ship successfully.'
    else
      redirect_to winners_path, alert: 'Unable to ship.'
    end

  end

  def deliver
    if @winner.deliver!
      redirect_to winners_path, notice: 'Delivered successfully.'
    else
      redirect_to winners_path, alert: 'Unable deliver.'
    end

  end

  def share
    if @winner.share!
      redirect_to winners_path, notice: 'Item started successfully.'
    else
      redirect_to winners_path, alert: 'Unable to start winner.'
    end

  end

  def publish
    if @winner.publish!
      redirect_to winners_path, notice: 'Published successfully.'
    else
      redirect_to winners_path, alert: 'Unable to publish.'
    end

  end

  def remove_publish
    if @winner.remove_publish!
      redirect_to winners_path, notice: 'removed publish successfully.'
    else
      redirect_to winners_path, alert: 'Unable to remove publish.'
    end

  end


end

