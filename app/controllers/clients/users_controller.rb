class Clients::UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :check_client

  def index
  end

  def check_client
    raise ActionController::RoutingError.new('Not Found') unless current_user.client?
  end
end
