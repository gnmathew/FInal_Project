class Admins::CategoriesController < Admins::BaseController
  before_action :set_category, only: [:edit, :update, :destroy]
  def index
    @categories = Category.all
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new(category_params)
    if @category.save
      flash[:notice] = "You Have successfully created a category"
      redirect_to categories_path
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @category.update(category_params)
      flash[:notice] = "Category successfully updated"
      redirect_to categories_path
    else
      render :edit
    end
  end

  def destroy
    begin
      @category.destroy
      flash[:notice] = 'Category deleted successfully'
    rescue ActiveRecord::DeleteRestrictionError => e
      flash[:alert] = 'Cannot delete category because it has dependent items.'
    end
    redirect_to categories_path
  end

  private

  def set_category
    @category = Category.find(params[:id])
  end

  def category_params
    params.require(:category).permit(:name)
  end
end
