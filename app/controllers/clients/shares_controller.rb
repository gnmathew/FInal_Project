class Clients::SharesController < ApplicationController
  def index
    @shares = Winner.published
    @banners = Banner.where(status: "active" ).where("created_at <= ?", Time.now).where("offline_at > ?", Time.now)
    @newstickers = Newsticker.where(status: "active")
  end

  def show
    @share = Winner.published.find(params[:id])
  end
end
