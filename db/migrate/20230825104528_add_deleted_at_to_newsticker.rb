class AddDeletedAtToNewsticker < ActiveRecord::Migration[7.0]
  def change
    add_column :newstickers, :deleted_at, :datetime, default: nil
  end
end
