module Admin
  class Admins::UsersController < Admins::BaseController
    def index
      @clients = User.client
    end
  end
end
