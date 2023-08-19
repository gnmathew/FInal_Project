class Offer < ApplicationRecord
  enum status: {active: 0, inactive: 1}
  enum genre: {one_time: 0, monthly: 1, weekly: 2, daily: 3, regular: 4}

  has_many :orders
  belongs_to :order, optional: true, if: :order_deposit?

  mount_uploader :image, ImageUploader

  private

  def order_deposit?
    order.where(genre: "deposit")
  end

end
