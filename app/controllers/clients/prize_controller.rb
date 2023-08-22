class Clients::PrizeController < ApplicationController
  def show
    @winner = Winner.find(params[:id])
  end

  def update
    @winner = Winner.find(params[:id])
    if @winner.update(address_id: params[:winner][:address_id])
      @winner.claim!
      flash[:notice] = "Successfully chose an Address"
    else
      flash[:alert] = "falied to choose an Address"
    end
    redirect_to profile_path
  end
end
