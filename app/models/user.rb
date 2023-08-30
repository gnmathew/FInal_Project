class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  after_create :check_member_level

  has_many :addresses
  has_many :bets
  has_many :winners
  has_many :orders
  belongs_to :member_level

  enum role: { client: 0, admin: 1 }

  validates :phone_number, phone: {
    possible: true,
    allow_blank: true,
    types: %i[voip mobile],
    countries: [:ph]
  }
  attr_accessor :promoter_name

  mount_uploader :image, ImageUploader

  has_many :children, class_name: 'User', foreign_key: 'parent_id'
  belongs_to :parent, class_name: 'User', optional: true, counter_cache: :children_members

  private

  def check_member_level
    return unless parent.present?
    promoter_member_count = parent.children_members
    promoter_member_level = parent.member_level
    next_member_level = MemberLevel.find_by("level > ?", promoter_member_level.level)

    if next_member_level && promoter_member_count >= next_member_level.required_members
      promoter_order = parent.orders.create(genre: "member_level", coin: next_member_level.coins)
      promoter_order.pay!
      parent.update(member_level: next_member_level)
    end
  end
end