class Admins::OffersController < Admins::BaseController
  before_action :set_offer, except: [:index, :new, :create]

  def index
    @offers = Offer.all

    if params[:genre].present?
      @offers = @offers.where(genre: params[:genre])
    end

    if params[:status].present?
      @offers = @offers.where(status: params[:status])
    end

  end

  def new
    @offer = Offer.new
  end

  def create
    @offer = Offer.new(offer_params)
    if @offer.save
      flash[:notice] = "You have successfully created an Offer"
      redirect_to offers_path
    else
      render :new
    end
  end

  def show
  end

  def edit
  end

  def update
    if @offer.update(offer_params)
      flash[:notice] = "successfully updated"
      redirect_to offers_path
    else
      render :edit
    end
  end

  def destroy
    if @offer.destroy
      flash[:notice] = "successfully deleted"
    else
      flash[:notice] = "Delete failed"
    end
    redirect_to offers_path
  end

  private

  def set_offer
    @offer = Offer.find(params[:id])
  end

  def offer_params
    params.require(:offer).permit(:image, :name, :genre, :status, :amount, :coin)
  end
end
