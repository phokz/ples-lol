require 'rqrcode' # Library for generating QR codes


colors = ["fcda81", "326c54", "fc7f07", "54b28d", "326c54", "d76f00"]

colors.each do |color|
  qr = RQRCode::QRCode.new("https://PLES.LOL/abc1234")
  qr_image = qr.as_png(size: 350, color: color, fill: "ffffff", border_modules: 0)
  IO.binwrite(color + ".png", qr_image.to_s)
end
