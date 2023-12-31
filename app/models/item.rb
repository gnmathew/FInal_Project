class Item < ApplicationRecord
  include AASM

  validates :image, :name, :quantity, :minimum_bets, :batch_count, :online_at, :offline_at, :start_at , presence: true

  belongs_to :category
  has_many :bets, dependent: :restrict_with_exception
  has_many :winners

  aasm column: :state do
    state :pending, initial: true
    state :starting
    state :paused
    state :ended
    state :cancelled

    event :start do
      transitions from: [:pending, :ended, :cancelled], to: :starting, after: :item_start, if: :can_start?
      transitions from: :paused, to: :starting
    end

    event :pause do
      transitions from: :starting, to: :paused
    end

    event :end do
      transitions from: :starting, to: :ended, guard: :reached_minimum_bets?, after: :pick_winner
    end

    event :cancel do
      transitions from: [:starting, :paused, :ended], to: :cancelled, after: [:cancel_bets,:restore_quantity]
    end

  end


  default_scope { where(deleted_at: nil) }

  enum status: { active: 0, inactive: 1}

  mount_uploader :image, ImageUploader



  def destroy
    update(deleted_at: Time.current)
  end


  private

  def can_start?
    quantity.positive? && offline_at > Time.now && status == 'active'
  end

  def item_start
    self.update(quantity: self.quantity - 1, batch_count: self.batch_count + 1)
  end

  def cancel_bets
    bets.where(batch_count: batch_count).each do |bet|
      if bet.may_cancel?
        bet.cancel!
      end
    end
  end

  def restore_quantity
    update(quantity: quantity + 1)
  end

  def reached_minimum_bets?
    bets.where(batch_count: batch_count).count >= minimum_bets
  end

  def pick_winner
    winning_bet = bets.where(batch_count: batch_count).sample
    losers_bets = bets.where(batch_count: batch_count) - [winning_bet]
    winning_bet.win!

    losers_bets.each do |loser_bet|
      loser_bet.lose!
    end

    Winner.create(user: winning_bet.user, item: winning_bet.item,
                              item_batch_count: batch_count, bet: winning_bet)
  end

end