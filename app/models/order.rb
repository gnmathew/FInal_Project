class Order < ApplicationRecord
  enum genre: {deposit: 0, increase: 1, deduct: 2, bonus: 3, share: 4}
end
