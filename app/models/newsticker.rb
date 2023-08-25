class Newsticker < ApplicationRecord
  default_scope { where(deleted_at: nil) }

  belongs_to :admin, class_name: 'User', optional: true

  enum status: {active: 0, inactive: 1}

  def destroy
    update(deleted_at: Time.now)
  end
end
