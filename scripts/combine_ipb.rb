require 'nokogiri'
require 'csv'
require 'fileutils'

# File paths
input_dir = '../ipb_files'
output_dir = '../outputs'
FileUtils.mkdir_p(output_dir)
output_file = File.join(output_dir, 'ipb_combined_report.csv')

# <part> container for the CSV
parts = []

# Process each XML file to extract root-level <part> data
Dir.glob("#{input_dir}/*.xml") do |file|
  doc = Nokogiri::XML(File.read(file))
  module_element = doc.at_xpath('/module')
  
  unless module_element
    raise "Missing 'module' element in XML"
  end
  module_name = module_element['name']

  # Populate 'parts' from root-level <part>s
  doc.xpath('//module/part').each do |part|
    parts << {
      'Part Number' => part.at_xpath('part_number')&.text,
      'Module' => module_name,
      'Description' => part.at_xpath('description')&.text
    }
  end
end

# Create and populate the CSV output file
CSV.open(output_file, 'w') do |csv|
  csv << ['Part Number', 'Module', 'Description']
  parts.each { |part_row| csv << part_row.values }
end

puts "CSV report generated at #{output_file}"
