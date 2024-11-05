# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end


def load_tables(table_location, tables)
  table_counter = 1
  for table in tables do 
    table_count = table[1] - table[0] + 1
    table_count.times do
        Table.create(number: table_counter, table_location: table_location, capacity: table[2])
      table_counter = table_counter + 1
    end
  end
end

# Hlavní sál
hl = TableLocation.create!(name: "Majekovského sál", price: 600)

# number of the first table, number of the last table, table capacity (number of seats)
hl_tables = [
  [1, 16, 8],
  [17, 24, 10],
  [25, 28, 12],
  [29, 34, 6],
  [35, 40, 8],
  [41, 44, 4],
  [45, 45, 6],
  [46, 49, 4],
]

load_tables(hl, hl_tables)

# Balkón
bl = TableLocation.create!(name: "Balkón", price: 550)

bl_tables = [
  [1, 7, 8],
  [8, 8, 12],
  [9, 10, 5],
  [11, 11, 10],
  [12, 12, 5],
  [13, 13, 10],
  [14, 15, 5],
  [16, 16, 8],
  [17, 17, 5],
  [18, 25, 8]
]

load_tables(bl, bl_tables)

# Raisův sál
rs = TableLocation.create!(name: "Raisův sál", price: 450)

rs_tables = [
  [1, 3, 6],
  [4, 7, 14],
  [8, 15, 10],
  [16, 19, 8]
]

load_tables(rs, rs_tables)

# Společenský sál
ss = TableLocation.create!(name: "Společenský sál", price: 450)

ss_tables = [
  [1, 20, 6]
]

load_tables(ss, ss_tables)

# Stání
s = TableLocation.create!(name: "Stání", price: 350)

s_tables = [
  [1, 1, 155]
]

load_tables(s, s_tables)
