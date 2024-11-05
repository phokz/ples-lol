class Ticket < ApplicationRecord
  belongs_to :table
  belongs_to :user, optional: true

  after_create :set_digest

  def set_digest
    update_column(:digest, calc_digest)
  end

  def calc_digest
    Digest::SHA2.new(256).hexdigest(secret+id.to_s).upcase[0..7]
  end
  
  def generate_ticket
    # [color, filling]
    colors = ["#fcda81", "#2c5a43"]
    template = Magick::Image.read(Rails.root.join("app/assets/images/ticket3.png")).first

    # Set up the text to annotate

    if self.table.table_location.name == "Stání"
    content = "Národní dům na Vinohradech
11.1.2025 18:00
#{self.table.table_location.name}
#{self.table.table_location.price},-"
  else
    content = "Národní dům na Vinohradech
11.1.2025 18:00
#{self.table.table_location.name}, stůl č. #{self.table.number}
#{self.table.table_location.price},-"
  end

    # Annotate title
    draw = Magick::Draw.new
    draw.gravity = Magick::NorthWestGravity

    # Digest
    draw.pointsize = 20
    draw.fill = colors[0]
    draw.annotate(template, 0, 0, 1467-53, 438+54*2/3, self.digest)

    # TableLocation
    draw.pointsize = 40
    draw.font = "URW Gothic"
    draw.fill = colors[1]
    draw.interline_spacing = 12

    # Annotate subtitle
    draw.annotate(template, 0, 0, 126, 241, content)

    # Annotate details

    # Generate QR code
    qr = RQRCode::QRCode.new("https://PLES.LOL/" + self.digest)
    qr_image = qr.as_png(size: 332, color: colors[0], fill: colors[1], border_modules: 0)

    # Convert QR code to ImageMagick format
    qr_magick = Magick::Image.from_blob(qr_image.to_blob) { format = 'png' }.first
    qr_magick.resize!(332, 332)

    # Composite QR code onto template
    template.composite!(qr_magick, Magick::NorthWestGravity, 1300, 106, Magick::OverCompositeOp)

    # Save the final ticket image
    template.write(Rails.root.join("ticket-generator/output/#{self.table.table_location.name.gsub(" ", "-") + "-" + self.table.number.to_s + "-" + self.id.to_s}.png"))
  end

  def self.generate_tickets
    Ticket.all.each do |ticket|
      ticket.generate_ticket
    end
  end

private
  def secret
    'sul a pepr'
  end
end
