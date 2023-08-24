class AddDefaultValueTotalDepositToUsers < ActiveRecord::Migration[7.0]
  def change
    remove_column :users, :total_deposit
    add_column :users, :total_deposit, :float, default: 0
  end
end
