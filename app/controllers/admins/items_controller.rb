class Admins::ItemsController < Admins::BaseController
  before_action :set_item, except: [:index, :new, :create]
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

  def start
    if @item.start!
      redirect_to items_path, notice: 'Item started successfully.'
    else
      redirect_to items_path, alert: 'Unable to start item.'
    end
  end

  def pause
    if @item.pause!
      redirect_to items_path, notice: 'Item paused.'
    else
      redirect_to items_path, alert: 'Unable to pause item.'
    end
  end

  def cancel
    if @item.cancel!
      redirect_to items_path, notice: 'Item cancelled.'
    else
      redirect_to items_path, alert: 'Unable to cancel item.'
    end

  end

  def end
    if @item.end!
      redirect_to items_path, notice: 'Item ended.'
    else
      redirect_to items_path, alert: 'Unable to end item.'
    end

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
