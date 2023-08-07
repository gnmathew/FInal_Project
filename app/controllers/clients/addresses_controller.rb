class Clients::AddressesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_address, only: [:edit, :update, :destroy]
  before_action :check_address_limit, only: [:new]

  def index
    @addresses = Address.includes(:region, :province  , :city, :barangay).all
  end

  def new
    @address = Address.new
  end

  def create
    @address = Address.new(address_params)
    @address.user = current_user

    if @address.save
      if @address.is_default?
        current_user.addresses.where.not(id: @address.id).update_all(is_default: false)
      end
      flash[:notice] = 'Address created successfully'
      redirect_to addresses_path
    else
      flash.now[:alert] = 'Address create failed'
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @address = Address.find(params[:id])
  end

  def update

    @address = Address.find(params[:id])
    if @address.update(address_params)
      if @address.is_default?
        current_user.addresses.where.not(id: @address.id).update_all(is_default: false)
      end
      flash[:notice] = 'Address updated successfully'
      redirect_to addresses_path
    else
      flash.now[:alert] = 'Address update failed'
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    address = Address.find(params[:id])
    address.destroy
    redirect_to addresses_path, notice: "Address deleted successfully."
  end

  private

  def set_address
    @address = Address.find(params[:id])
  end

  def address_params
    params.require(:address).permit(:address_region_id, :address_province_id, :address_city_id, :address_barangay_id, :genre, :is_default, :street_address)
      .merge(genre: params[:address][:genre].to_i)
  end

  def check_address_limit
    if current_user.addresses.count >= 5
      redirect_to addresses_path, alert: "You already have 5 addresses. You can't add more."
    end
  end

end
