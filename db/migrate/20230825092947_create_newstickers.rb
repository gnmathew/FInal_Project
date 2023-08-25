class CreateNewstickers < ActiveRecord::Migration[7.0]
  def change
    create_table :newstickers do |t|
      t.string :content
      t.integer :status
      t.references :admin

      t.timestamps
    end
  end
end
