class Address::Barangay < ApplicationRecord
  validates :name, presence: true
  validates :code, uniqueness: true

  belongs_to :city

  has_many :addresses, class_name: 'Address', foreign_key: 'address_barangay_id'

  def self.table_name_prefix
    "address_"
  end
end
