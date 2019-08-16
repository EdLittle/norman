# require 'pry'
require 'csv'

# 
# for sheet 2
#
doc = CSV.read('processed_batch/2.csv', headers: true)
previous_id = ''

normalized_doc = CSV.open('normalized_sheet_2.csv', 'wb') do |norm|
  norm << ['id', 'classification', 'confidence']
  doc.each do |x|
    id = if !x['id'].nil?
           previous_id = x['id']
           x['id']
         elsif x['id'].nil?
           previous_id
         end
    norm << [id, x['Classification'], x['Level 1 confidence']]
  end
end

# SHEET 1
#
#
doc = CSV.read('processed_batch/1.csv', headers: true)

normalized_doc = CSV.open('normalized_sheet_1.csv', 'wb') do |norm|
  norm << ['id', 'org_type']
  doc.each do |row|
    if !row['Organization Type(s)'].nil?
      row['Organization Type(s)'].split(',').each do |org_type|
        norm << [row['ID'], org_type]
      end
    else
      norm << [row['ID'], nil]
    end
  end
end
