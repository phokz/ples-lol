class Ticket < ApplicationRecord
  belongs_to :ticket_type
  belongs_to :user, optional: true

  after_create :set_digest

  def set_digest
    update_column(:digest, calc_digest)
  end

  def calc_digest
    Digest::SHA2.new(256).hexdigest(secret+id.to_s).upcase[0..7]
  end

private
  def secret
    'sul a pepr'
  end
end
