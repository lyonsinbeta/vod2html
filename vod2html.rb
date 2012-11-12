require 'optparse'
require './config.rb'

def normalize_directory(dir)
  normalized = dir.gsub('\\', '/')
  normalized += '/' unless normalized[-1] == '/'
end

def output_html_wrapper(flv_filename, output_folder)
  html_filename = flv_filename.sub(flv_filename[/(?:.*\.)(.*$)/, 1], "html")

  html_body = $EMBED_HTML.gsub($SAMPLE_FLV, flv_filename.sub(/[a-z][:]/, '')) 
  html_output = File.open(html_filename, "w")
  html_output.write(html_body)

  link = flv_filename.sub(/[a-z][:]/, '').sub(flv_filename[/(?:.*\.)(.*$)/, 1], "html")
  link_list = File.open("#{output_folder}List of Links.txt", "a")
  link_list.write($BASE_URL + link + "\n")
	
  return html_filename
end

options = {}
OptionParser.new do |opts|
  opts.banner = "\nThank you for using #{$0}."

  opts.on("-r", "--recursive", "Recursively scan subdirectories") do |r|
	options[:recursive] = r
  end

  opts.on("-b", "--bothtypes", "Scans for .f4v in addition to .flv") do |b|
	options[:bothtypes] = b
	$FILE_TYPES << "f4v"
  end

  opts.on("-m", "--mp4", "Scans for .mp4 in addition to .flv. USE WITH CAUTION") do |m|
  options[:mp4] = m
  $FILE_TYPES << "mp4"
  end

  opts.on("-h", "--help", "Displays help") do
	puts opts
	exit
  end
end.parse!

puts "Enter the full directory path of the flv files." unless ARGV[0]
ARGV[0] ? top_folder = normalize_directory(ARGV[0]) : top_folder = normalize_directory(gets.chomp)

options[:recursive] ? search = top_folder + "**/" : search = top_folder
  
until Dir.glob("#{search}*.{#{$FILE_TYPES.join(",")}}") != []
  puts "That directory either doesn't exist or contains no flash videos. \nEnter the full directory path of the flash video files."
  top_folder = normalize_directory($stdin.gets.chomp)
  options[:recursive] ? search = top_folder + "**/" : search = top_folder
end

flvs = Dir.glob("#{search}*.{#{$FILE_TYPES.join(",")}}") 
File.delete("#{top_folder}List of Links.txt") if File.exists?("#{top_folder}List of Links.txt")
flvs.sort_by! { |flv| flv.scan("/").length }
flvs.each { |flv|
  html_filename = output_html_wrapper(flv, top_folder)
  puts "#{html_filename} created successfully." if File.exists?(html_filename)
  }

