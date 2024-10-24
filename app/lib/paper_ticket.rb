# frozen_string_literal: true

class PaperTicket
  def initialize(name, price, digest)
    @name = name
    @price = price
    @digest = digest
  end

  def label
    background = Magick::Image.read(Rails.root.join('/app/assets/images/ticket.jpeg')).first
    background.composite!(code, Magick::NorthEastGravity, 0, 0, Magick::OverCompositeOp)

    background.composite!(coords_letter, Magick::NorthWestGravity, 0, 0, Magick::OverCompositeOp)
    background.composite!(coords_number, Magick::NorthGravity, 116, 0, Magick::OverCompositeOp)
    background.composite!(caption, Magick::NorthGravity, 0, 0, Magick::OverCompositeOp)

    background.format = 'png'
    background.to_blob
  end

  def coords_letter
    Magick::Image.read("caption:#{letter}") do |i|
      i.size = '538x262' # Text box size
      i.background_color = 'none' # transparent
      i.pointsize = 37 # font size
      i.font = 'Bassanova' # font family
      i.fill = 'red' # font color
      i.gravity = Magick::EastGravity # Text orientation
    end.first
  end

  def coords_number
    Magick::Image.read("caption:#{number}") do |i|
      i.size = '279x232' # Text box size
      i.background_color = 'none' # transparent
      i.background_color = 'none' # transparent
      i.pointsize = 99 # font size
      i.font = 'Helvetica' # font family
      i.fill = 'black' # font color
      i.gravity = Magick::WestGravity # Text orientation
    end.first
  end

  def caption
    Magick::Image.read("caption:#{name}") do |i|
      i.size = '538x262' # Text box size
      i.background_color = 'none' # transparent
      i.pointsize = 37 # font size
      i.font = 'Helvetica' # font family
      i.fill = 'black' # font color
      i.gravity = Magick::SouthGravity # Text orientation
    end.first
  end

  def code
    Magick::Image.from_blob(qrcode.to_s).first
  end

  def qrcode
    code = RQRCode::QRCode.new('https://ples.lol/' + @digest)
    code.as_png(size: 236, border_modules: 1)
  end

  def generate_ticket(ticket)

  end
end

