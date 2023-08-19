class Order < ApplicationRecord
  belongs_to :user
  belongs_to :offer

  enum genre: {deposit: 0, increase: 1, deduct: 2, bonus: 3, share: 4}

end
