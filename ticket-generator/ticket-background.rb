require 'rmagick'

bg_color = "#faa334"
text_color = "#ffffff"
input_file_path = 'names.txt'
symbol = "\u2605".encode("utf-8")
symbol = "-"
pixels_per_cm = 118

names = []
File.open(input_file_path).each_line do |line|
  names.append(line.strip)
end

names_to_annotate = ""
400.times do
  row = symbol + " "
  45.times do
    row += names.sample + " " + symbol + " "
  end
  names_to_annotate += row + "\n"
end

bg = Magick::Image.new(32*pixels_per_cm, 45*pixels_per_cm) { |options| options.background_color = bg_color }

draw = Magick::Draw.new
draw.gravity = Magick::CenterGravity
draw.pointsize = 20
draw.fill = text_color
draw.rotation = -45
draw.interline_spacing = 3
draw.encoding = "utf-8"
draw.annotate(bg, 0, 0, 0, 250, names_to_annotate.encode("utf-8"))


bg.write("back.png")
