require 'rmagick'

bg_color = "000fff"
bg = Magick::Image.new(800, 800)
bg.background_color = Magick::Pixel.new(0, 0, 0, 1)
bg.write("back.png")
