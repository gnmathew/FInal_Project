class Admins::NewstickerController < Admins::BaseController
  before_action :set_newsticker, except: [:index, :new, :create]
  def index
    @newstickers = Newsticker.all
  end

  def show
  end

  def new
    @newsticker = Newsticker.new
  end

  def create
    @newsticker = Newsticker.new(newsticker_params)
    @newsticker.admin = current_admin_user
    if @newsticker.save
      flash[:notice] = "You have successfully created a NewsTicker"
      redirect_to newsticker_index_path
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @newsticker.update(newsticker_params)
      flash[:notice] = "You have successfully updated a NewsTicker"
      redirect_to newsticker_index_path
    else
      render :edit
    end
  end

  def destroy
    if @newsticker.destroy
      flash[:notice] = 'Deleted successfully'
    else
      flash[:alert] = 'Delete failed'
    end
    redirect_to newsticker_index_path
  end

  private

  def set_newsticker
    @newsticker = Newsticker.find(params[:id])
  end

  def newsticker_params
    params.require(:newsticker).permit(:content, :status)
  end
end
