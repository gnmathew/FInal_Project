class Admins::ItemsController < Admins::BaseController
  before_action :set_item, only: [:show, :edit, :update, :destroy]
  def index
    @items = Item.all
  end

  def show
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      flash[:notice] = "You have successfully created an item"
      redirect_to items_path
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @item.update(item_params)
      flash[:notice] = "successfully updated"
      redirect_to items_path
    else
      render :edit
    end
  end

  def destroy
    if @item.destroy
      flash[:notice] = 'Deleted successfully'
    else
      flash[:alert] = 'Delete failed'
    end
    redirect_to items_path
  end

  private

  def set_item
    @item = Item.find(params[:id])
  end

  def item_params
    params.require(:item).permit(:image, :name, :quantity, :minimum_bets,
                                 :batch_count, :online_at, :offline_at, :status, :start_at, :category_id)
  end
end
