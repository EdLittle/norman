require 'csv'
doc_filename = 'AD-Norm5.csv'

doc = CSV.read(doc_filename, headers: true)

CSV.open('normalized_' + doc_filename, 'wb') do |norm|
  norm << doc.headers.compact
  puts doc.headers.compact
  doc.each do |row|
    hash = row.to_h
    values = CSV.parse_line(row.to_s).drop(1).compact
    values.each do |val|
      norm << [hash['CODE'], val]
    end
  end
end
