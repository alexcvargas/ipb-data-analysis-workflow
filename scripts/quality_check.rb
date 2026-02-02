require 'csv'

report_file = '../outputs/ipb_combined_report.csv'
rows = CSV.read(report_file, headers: true)

# Missing descriptions for any root-level part number
missing_desc = rows.select do |row|
  row['Description'].nil? ||
  row['Description'].strip.empty?
end

# Create a new hash: { part_num => [matching rows] }
grouped = rows.group_by { |row| row['Part Number'] }
duplicates = grouped.select { |part_num, matching_rows| matching_rows.size > 1 }

puts "--- Missing Descriptions ---"
if missing_desc.any?
  missing_desc.each do |row|
    puts "#{row['Part Number']} (Module: #{row['Module']})"
  end
else
  puts "None"
end

puts "\n--- Duplicate Part Numbers ---"
if duplicates.any?
  duplicates.each do |part_num, matching_rows|
    modules = matching_rows.map { |row| row['Module'] }.join(', ')
    puts "#{part_num} - found in: #{modules}"
  end
else
  puts "None"
end
