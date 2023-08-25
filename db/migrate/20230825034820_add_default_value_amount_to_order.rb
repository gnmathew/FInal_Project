class AddDefaultValueAmountToOrder < ActiveRecord::Migration[7.0]
  def change
    remove_column :orders, :amount
    add_column :orders, :amount, :float, default: 0
  end
end
