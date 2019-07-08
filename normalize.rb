require 'pp'
require 'csv'
require 'pry'
require 'active_support/core_ext/hash'

# ruby normalize.rb document_name header_to_normalize ','
raise StandardError if ARGV.length < 2

# filename
doc_filename = ARGV[0]
doc = CSV.read(doc_filename, headers: true)

# column header name to be normalized
header_to_normalize = ARGV[1]

# make the default delimiter to split from the new line character
delimiter = ARGV[2] || "\n"

puts "Document to Normalize: #{doc_filename}"
puts "Column header to normalize: #{header_to_normalize}"
puts "Delimiter: #{delimiter}"

normalized_doc = CSV.open('normalized_' + doc_filename, 'wb') do |norm|
  norm << doc.headers

  doc.each do |x|
    begin
      next unless x[header_to_normalize].present?
      # binding.pry
      # splitzies = x[header_to_normalize].split(
      #   "#{delimiter}(?=(?:[^\"]*\"[^\"]*\")*[^\"]*$)"
      # );
      binding.pry
      splitzies = x[header_to_normalize].split(delimiter)
      splitzies.map(&:strip).uniq.each do |val|
        norm << [x.to_h.except(header_to_normalize).values, val].flatten
      end
    rescue
      binding.pry
    end
  end
end

