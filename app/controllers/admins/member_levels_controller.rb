class Admins::MemberLevelsController < Admins::BaseController
  before_action :set_member_level, except: [:index, :new, :create]

  def index
    @member_levels = MemberLevel.all
  end

  def new
    @member_level = MemberLevel.new
  end

  def create
    @member_level = MemberLevel.new(member_level_params)
    if @member_level.save
      flash[:notice] = "Successfully upgraded level"
    else
      flash[:alert] = "Failed to upgrade level"
    end
    redirect_to member_levels_path
  end

  def edit;end

  def update
    if @member_level.update(member_level_params)
      flash[:notice] = "Successfully Updated"
    else
      flash[:alert] = "Failed to Update"
    end
    redirect_to member_levels_path
  end

  def destroy
    if @member_level.destroy
      flash[:notice] = "Deleted Successfully"
    else
      flash[:alert] = "Failed to Delete"
    end
    redirect_to member_levels_path
  end

  private

  def set_member_level
    @member_level = MemberLevel.find(params[:id])
  end

  def member_level_params
    params.require(:member_level).permit(:level, :required_members, :coins)
  end
end
