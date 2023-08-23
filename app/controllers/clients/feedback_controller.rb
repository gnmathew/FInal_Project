class Clients::FeedbackController < ApplicationController
  before_action :authenticate_user!
  before_action :set_winner
  def show
  end

  def update
    winner_params = params.require(:winner).permit(:picture,:comment)
    if @winner.update(winner_params)
      @winner.share!
      flash[:notice] = "Successfully shared your feedback"
    else
      flash[:alert] = "Failed to share your feedback"
    end
    redirect_to profile_path
  end

  private

  def set_winner
    @winner = current_user.winners.delivered.find(params[:id])
  end
end
