class Table < ApplicationRecord
  belongs_to :table_location
  after_create :generate_tickets

  def generate_tickets
     capacity.times do
       Ticket.create!(table: self)
     end
  end
end
