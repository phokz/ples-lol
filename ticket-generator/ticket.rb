require 'rmagick'
require 'rqrcode' # Library for generating QR codes

# [color, filling]
colors = ["fcda81", "326c54"]
template = Magick::Image.read("/home/bakterio/Programming/ples-lol/app/assets/images/ticket-with-title.jpeg").first

# Set up the text to annotate
name = "Hlavní sál"
price = "350" + " Kč"
digest = "1234567"

# Annotate title
draw = Magick::Draw.new
draw.font = "/home/bakterio/Programming/ples-lol/app/assets/fonts/bosanova.ttf"
draw.pointsize = 30
draw.fill = 'white'
draw.gravity = Magick::NorthWestGravity
draw.annotate(template, 0, 0, 0, 30, name)

# Annotate subtitle
draw.pointsize = 20
draw.annotate(template, 0, 0, 0, 70, price)

# Annotate details
draw.pointsize = 18
draw.annotate(template, 0, 0, 1606-67/2, 546+20, digest)

# Generate QR code
qr = RQRCode::QRCode.new("https://PLES.LOL/abc1234")
qr_image = qr.as_png(size: 350, color: colors[0], fill: colors[1], border_modules: 0)

# Convert QR code to ImageMagick format
qr_magick = Magick::Image.from_blob(qr_image.to_blob) { format = 'png' }.first
qr_magick.resize!(345, 352)

# Composite QR code onto template
template.composite!(qr_magick, Magick::NorthWestGravity, 1434, 196, Magick::OverCompositeOp)

# Save the final ticket image
template.write("output.png")
