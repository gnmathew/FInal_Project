class MemberLevel < ApplicationRecord
  has_many :users, dependent: :nullify

  default_scope { order(level: :asc) }

end
