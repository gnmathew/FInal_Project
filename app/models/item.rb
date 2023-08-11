class Item < ApplicationRecord
  validates :image, :name, :quantity, :minimum_bets, :batch_count, :online_at, :offline_at, :start_at , presence: true

  default_scope { where(deleted_at: nil) }

  enum status: { active: 0, inactive: 1}

  mount_uploader :image, ImageUploader

  def destroy
    update(deleted_at: Time.current)
  end
end
