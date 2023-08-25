class Admins::BannersController < Admins::BaseController
  before_action :set_banner, except: [:index, :new, :create]

  def index
    @banners = Banner.all
  end

  def new
    @banner = Banner.new
  end

  def create
    @banner = Banner.new(banner_params)
    if @banner.save
      flash[:notice] = "You have successfully created a banner"
      redirect_to banners_path
    else
      flash[:alert] = "Failed created a banner"
      render :new
    end
  end

  def edit
  end

  def update
    if @banner.update(banner_params)
      flash[:notice] = "You have successfully updated a banner"
      redirect_to banners_path
    else
      flash[:alert] = "failed to update banner"
      render :edit
    end

  end

  def destroy
    if @banner.destroy
      flash[:notice] = 'Deleted successfully'
    else
      flash[:alert] = 'Delete failed'
    end
    redirect_to banners_path
  end

  private

  def set_banner
    @banner = Banner.find(params[:id])
  end

  def banner_params
    params.require(:banner).permit(:preview, :status, :offline_at, :online_at)
  end
end
