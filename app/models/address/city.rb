class Address::City < ApplicationRecord
  validates :name, presence: true
  validates :code, uniqueness: true

  belongs_to :province
  has_many :barangays

  has_many :addresses, class_name: 'Address', foreign_key: 'address_city_id'

  def self.table_name_prefix
    "address_"
  end
end
