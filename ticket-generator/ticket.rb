require 'rmagick'
require 'rqrcode' # Library for generating QR codes

# [color, filling]
colors = ["#fcda81", "#2c5a43"]
template = Magick::Image.read("/home/bakterio/Programming/ples-lol/app/assets/images/ticket3.png").first

# Set up the text to annotate
name = "Hlavní sál"
price = "350"
digest = "EC264FAC"
table = "5"

content = "Národní dům na Vinohradech
11.1.2025 18:00
#{name}, stůl č. #{table}
#{price},-"

# Annotate title
draw = Magick::Draw.new
draw.gravity = Magick::NorthWestGravity

# Digest
draw.pointsize = 20
draw.fill = colors[0]
draw.annotate(template, 0, 0, 1467-53, 438+54*2/3, digest)

# TableLocation
draw.pointsize = 40
draw.font = "URW Gothic"
draw.fill = colors[1]
draw.interline_spacing = 12

# Annotate subtitle
draw.annotate(template, 0, 0, 126, 241, content)

# Annotate details

# Generate QR code
qr = RQRCode::QRCode.new("https://PLES.LOL/abc1234")
qr_image = qr.as_png(size: 332, color: colors[0], fill: colors[1], border_modules: 0)

# Convert QR code to ImageMagick format
qr_magick = Magick::Image.from_blob(qr_image.to_blob) { format = 'png' }.first
qr_magick.resize!(332, 332)

# Composite QR code onto template
template.composite!(qr_magick, Magick::NorthWestGravity, 1300, 106, Magick::OverCompositeOp)

# Save the final ticket image
template.write("output.png")
