class Bet < ApplicationRecord
  include AASM

  belongs_to :item
  belongs_to :user

  after_create :assign_serial_number

  aasm column: :state do
    state :betting, initial: true
    state :won, :lost, :cancelled

    event :win do
      transitions from: :betting, to: :won
    end

    event :lose do
      transitions from: :betting, to: :lost
    end

    event :cancel do
      transitions from: :betting, to: :cancelled, after: :refund_coin
    end
  end

  private

  def subtract_coin
    user.update(coins: user.coins - 1)
  end

  def refund_coin
    user.update(coins: user.coins + 1)
  end

  def assign_serial_number
    number_count = format('%04d', item.bets.where(batch_count: item.batch_count).count)
    date_format = Time.current.strftime('%y%m%d')
    serial_number = "#{date_format}-#{item.id}-#{item.batch_count}-#{number_count}"
    update(serial_number: serial_number)
  end


end
