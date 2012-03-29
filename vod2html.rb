$EMBED_HTML = "" 

$BASE_URL = ""

def normalize_directory(dir)
	normalized = dir.gsub('\\', '/')
	normalized += '/' unless normalized[-1] == '/'
end

def validate_directory(dir)
	puts "Enter the full directory path of the flv files." unless dir
	dir =  dir || gets.chomp
	dir = normalize_directory(dir)
	until File.directory?(dir) && Dir.glob("#{dir}*.flv") != []
		puts "That directory either doesn't exist or contains no .flv files. \nEnter the full directory path of the flv files."
		dir = $stdin.gets.chomp
		dir = normalize_directory(dir)
	end

	dir
end

def output_html_wrapper(flv_filename, output_folder)
  html_filename = flv_filename.gsub(".flv", ".html")

  html_body = $EMBED_HTML.gsub("sample.flv", flv_filename.slice(7..flv_filename.length)) 
  html_output = File.open(html_filename, "w")
  html_output.write(html_body)
  html_output.close

  link = flv_filename.slice(2..flv_filename.length).gsub(".flv", ".html")
  link_list = File.open("#{output_folder}List of Links.txt", "a")
  link_list.write($BASE_URL + link + "\n")
  link_list.close
	
  puts "#{html_filename} created successfully." if File.exists?(html_filename)
end

folder = ARGV[0].dup unless ARGV.empty?
folder = validate_directory(folder)
flvs = Dir.glob("#{folder}*.flv") 
File.delete("#{folder}List of Links.txt") if File.exists?("#{folder}List of Links.txt")
flvs.each { |flv| output_html_wrapper(flv, folder) }