$EMBED_HTML = "" 

$BASE_URL = ""

$SAMPLE_FLV = ""

def normalize_directory(dir)
  normalized = dir.gsub('\\', '/')
  normalized += '/' unless normalized[-1] == '/'
end

def output_html_wrapper(flv_filename, output_folder)
  html_filename = flv_filename.gsub(".flv", ".html")

  html_body = $EMBED_HTML.gsub($SAMPLE_FLV, flv_filename.sub(/[a-z][:]/, '')) 
  html_output = File.open(html_filename, "w")
  html_output.write(html_body)
  html_output.close

  link = flv_filename.sub(/[a-z][:]/, '').gsub(".flv", ".html")
  link_list = File.open("#{output_folder}List of Links.txt", "a")
  link_list.write($BASE_URL + link + "\n")
  link_list.close
	
  return html_filename
end

puts "Enter the full directory path of the flv files." unless ARGV[0]
ARGV[0] ? folder = normalize_directory(ARGV[0]) : folder = normalize_directory(gets.chomp)
  
until Dir.glob("#{folder}*.flv") != []
  puts "That directory either doesn't exist or contains no .flv files. \nEnter the full directory path of the flv files."
  folder = normalize_directory($stdin.gets.chomp)
end

flvs = Dir.glob("#{folder}*.flv") 
File.delete("#{folder}List of Links.txt") if File.exists?("#{folder}List of Links.txt")
flvs.each { 
  |flv| 
  html_filename = output_html_wrapper(flv, folder) 
  puts "#{html_filename} created successfully." if File.exists?(html_filename)
}