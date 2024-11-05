class CreateTables < ActiveRecord::Migration[7.2]
  def change
    create_table :tables do |t|
      t.integer :number
      t.integer :capacity
      t.references :table_location, null: false, foreign_key: true

      t.timestamps
    end
  end
end
