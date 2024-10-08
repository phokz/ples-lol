class TicketType < ApplicationRecord
  after_create :generate_tickets
  def generate_tickets
     quantity.times do
       Ticket.create!(ticket_type: self)
     end
  end
end
