class Offer < ApplicationRecord
  validates :image, :name, :genre, :status, presence: true
  validates :amount, :coin, presence: true, if: :order_deposit?

  enum status: {active: 0, inactive: 1}
  enum genre: {one_time: 0, monthly: 1, weekly: 2, daily: 3, regular: 4}

  has_many :orders
  belongs_to :order, optional: true

  mount_uploader :image, ImageUploader

  private

  def order_deposit?
    orders.exists?(genre: "deposit")
  end

end
