class Clients::UsersController < ApplicationController
  def invite_people
    @promoter_email = params[:promoter]
    cookies[:promoter_email] = @promoter_email if @promoter_email

    qrcode = RQRCode::QRCode.new(new_user_registration_path(promoter: @promoter_email))
    @qrcode_svg = qrcode.as_svg(module_size: 4)
  end

end
