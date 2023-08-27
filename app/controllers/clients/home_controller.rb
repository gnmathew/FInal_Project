class Clients::HomeController < ApplicationController
  def index
    @banners = Banner.where(status: "active" ).where("created_at <= ?", Time.now).where("offline_at > ?", Time.now)
    @newstickers = Newsticker.where(status: "active")
  end

end
