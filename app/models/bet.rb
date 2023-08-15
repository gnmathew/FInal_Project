class Bet < ApplicationRecord
  include AASM

  belongs_to :item, primary_key: :batch_count, foreign_key: :batch_count
  belongs_to :user

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

  before_create :subtract_coin, #:assign_serial_number

  private

  def subtract_coin
    user.update(coins: user.coins - 1)
  end

  def refund_coin
    user.update(coins: user.coins + (coins - 1))
  end

  # def assign_serial_number
  #   number_count = format('%04d', batch_count)
  #   date_format = Time.current.strftime('%y%m%d')
  #   self.serial_number = "#{date_format}-#{item.id}-#{item.batch_count}-#{number_count}"
  # end

end
