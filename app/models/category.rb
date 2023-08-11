class Category < ApplicationRecord
  validates :name, presence: true

  has_many :items, dependent: :restrict_with_exception
end
