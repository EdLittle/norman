require 'csv'

filename = 'AD-Norm3.csv'

doc = CSV.read(filename, headers: true)

CSV.open('normalized_' + filename, 'wb') do |norm|
  norm << ['CODE', 'Main Delivery Channel']
  doc.each do |row|
    hash = row.to_h
    # puts hash
    puts row.to_s
    puts CSV.parse_line(row.to_s)
    values = CSV.parse_line(row.to_s).drop(1).compact
    values.each do |val|
      norm << [row['CODE'], val]
    end
  end
end
