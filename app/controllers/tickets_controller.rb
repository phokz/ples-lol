class TicketsController < ApplicationController
  def index
  end

  def show
     @ticket = Ticket.find_by_digest(params[:id])
     if @ticket.scanned_at.nil?
        @ticket.update(scanned_at: Time.now)
        render action: 'cajk'
     else
        render action: 'fuj'
     end
  end
  def cajk
    @ticket = Ticket.first
  end
end
