class Admins::InviteController < Admins::BaseController
  def index
    @invitees = User.where.not(parent_id: nil)

    if params[:parent_email].present?
      parent_users = User.where("email LIKE ?", "%#{params[:parent_email]}%")
      @invitees = @invitees.where(parent_id: parent_users.pluck(:id))
    end

  end
end
