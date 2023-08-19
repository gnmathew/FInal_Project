class Admins::OffersController < Admins::BaseController

  def index
    if params[:genre].present?
      @offers = @offers.where(genre: params[:genre])
    end

    if params[:status].present?
      @offers = @offers.where(status: params[:status])
    end

  end

  def new
  end

  def create
  end

  def show
  end

  def edit
  end

  def update
  end

  def destroy
  end
end
