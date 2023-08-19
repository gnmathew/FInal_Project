class Order < ApplicationRecord
  include AASM

  belongs_to :user
  belongs_to :offer

  after_create :assign_serial_number

  validates :amount, presence: true, if: :genre_deposit?

  enum genre: {deposit: 0, increase: 1, deduct: 2, bonus: 3, share: 4}


  aasm column: :state do
    state :pending, initial: true
    state :submitted, :cancelled, :paid

    event :submit do
      transitions from: :pending, to: :submitted
    end

    event :cancel do
      transitions from: [:pending, :submitted], to: :cancelled
      transitions from: [:paid], to: :cancelled, guard: [:increase_user_coins_cancelled, :decrease_user_coins_cancelled,
                                                         :decrease_total_deposit]
    end

    event :pay do
      transitions from: :submitted, to: :paid, after: [:increase_user_coins_paid, :decrease_user_coins_paid, :increase_total_deposit]
    end
  end


  private

  def genre_deposit?
    genre == "deposit"
  end

  def genre_deduct?
    genre == "deduct"
  end
  def increase_user_coins_paid
    unless genre_deduct?
      user.update(coins: user.coins + value)
    end
  end

  def decrease_user_coins_paid
    if genre_deduct?
      user.update(coins: user.coins - value)
    end
  end

  def increase_total_deposit
    if genre_deposit?
      user.update(total_deposit: user.total_deposit + value)
    end
  end

  def decrease_user_coins_cancelled
    unless genre_deduct?
      user.update(coins: user.coins - 1)
    end
  end

  def increase_user_coins_cancelled
    if genre_deduct?
      user.update(coins: user.coins + 1)
    end
  end

  def decrease_total_deposit
    if genre_deposit?
      user.update(total_deposit: user.total_deposit - 1)
    end
  end

  def assign_serial_number
    number_count = user.orders.count
    date_format = Time.current.strftime('%y%m%d')
    serial_number = "#{date_format}-#{self.id}-#{user.id}-#{number_count}"
    update(serial_number: serial_number)
  end

end
