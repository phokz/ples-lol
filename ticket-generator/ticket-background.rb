require 'rmagick'

bg_color = "#faa334"
text_color = "#ffffff"
input_file_path = 'names.txt'

names = []
File.open(input_file_path).each_line do |line|
  names.append(line.strip)
end

names_to_annotate = ""
100.times do
  row = "* "
  30.times do
    row += names.sample + " * "
  end
  row += " *"
  names_to_annotate += row + "\n"
end

bg = Magick::Image.new(1500, 500) { |options| options.background_color = bg_color }

draw = Magick::Draw.new
draw.gravity = Magick::CenterGravity
draw.pointsize = 20
draw.fill = text_color
draw.rotation = -45
draw.interline_spacing = 3
draw.annotate(bg, 0, 0, 0, 250, names_to_annotate)


bg.write("back.png")
