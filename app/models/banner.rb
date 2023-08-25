class Banner < ApplicationRecord
  validates :preview, presence: true

  default_scope { where(deleted_at: nil) }

  enum status: { active: 0, inactive: 1 }

  mount_uploader :preview, ImageUploader

  def destroy
    update(deleted_at: Time.current)
  end
end
