class Clients::HomeController < ApplicationController
  def index
    @banners = Banner.where(status: "active" ).where("created_at <= ?", Time.now).where("offline_at > ?", Time.now)
    @newstickers = Newsticker.where(status: "active")
    @last_five_feedbacks = Winner.published.last(5)
    @starting_items = Item.active.starting.first(8)
  end

end
