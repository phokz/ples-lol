class CreateTickets < ActiveRecord::Migration[7.2]
  def change
    create_table :tickets do |t|
      t.references :table, null: false, foreign_key: true
      t.string :digest, null: false, default: '', index: true
      t.datetime :scanned_at
      t.references :user, null: true, foreign_key: true

      t.timestamps
    end
  end
end
