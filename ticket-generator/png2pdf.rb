require 'rmagick'

pixels_per_cm = 118
t_h = 591 # ticket height
t_w = 1772 # ticket width

bg = Magick::Image.new(32*pixels_per_cm, 45*pixels_per_cm)
arrow = Magick::Image.read("arrow.png").first.resize(100, 100)

9.times do |i|
  append_image =  Magick::Image.read('output.png').first
  bg.composite!(append_image, pixels_per_cm, i*t_h, Magick::OverCompositeOp)
end

9.times do |i|
  append_image =  Magick::Image.read('output.png').first
  bg.composite!(append_image, pixels_per_cm+t_w, i*t_h, Magick::OverCompositeOp)
end

9.times do |i|
  bg.composite!(arrow, 59-50, i*t_h-50, Magick::OverCompositeOp)
  bg.composite!(arrow, 32*pixels_per_cm-(59+50), i*t_h-50, Magick::OverCompositeOp)
end
bg.write("pdf.pdf")
