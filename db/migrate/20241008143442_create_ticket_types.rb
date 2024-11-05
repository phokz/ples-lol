class CreateTicketTypes < ActiveRecord::Migration[7.2]
  def change
    create_table :table_locations do |t|
      t.decimal :price
      t.string :name

      t.timestamps
    end
  end
end
