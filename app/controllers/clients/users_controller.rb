class Clients::UsersController < ApplicationController
  def invite_people
    get_promoter
    qrcode = RQRCode::QRCode.new(@promoter_email)
    @qrcode_svg = qrcode.as_svg(module_size: 4)
  end

  def get_promoter
    if user_signed_in?
      @promoter_email = "client.com:3000/users/sign_up?promoter=#{current_user.email}"
    else
      @promoter_email = 'http://client.com:3000/users/sign_in'
    end
  end
end
