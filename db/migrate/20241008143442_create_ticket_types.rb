class CreateTicketTypes < ActiveRecord::Migration[7.2]
  def change
    create_table :ticket_types do |t|
      t.decimal :price
      t.string :name
      t.integer :quantity

      t.timestamps
    end
  end
end
