puts "\n \n \n \n"
puts "#######################################################################"
puts "#                                                                     #"
puts "# vod2html v1.0 does not carry any license and is free to be          #"
puts "# vod2html v0.9 does not carry any license and is free to be          #"
puts "# distributed or altered. Enjoy!                                      #"
puts "# --                                                                  #"
puts "# David Lyons                                                         #"
puts "#                                                                     #"
puts "#######################################################################"
puts "\n \n \n \n"

###### Methods ######

### Cleans up and validates user input, or forces resubmission of user input
def is_valid_dir()
	puts "Enter the full directory path of the flv files."
	input = gets.chomp
	input.gsub!('\\', '/')
	input += '/' unless input[-1..-1] == '/'
	until File.directory?(input) && Dir.glob("#{input}*.flv") != []
		puts "That directory either doesn't exist or contains no .flv files. \n Enter the full directory path of the flv files."
		input = gets.chomp
		input.gsub!('\\', '/')
		input += '/' unless input[-1..-1] == '/'
	end
return input
end

### For each .flv in the directory create an html document named
### like the flv, edit the default embed code, and write it to a file.
### Also creates a .txt with a list of all the URLs for the files in that folder.

def output(flv, location)
	### HTML embed code
	embed = "" # Insert your embed HTML into this variable.

	### URL base
	base = "" # Inset the url where your organization stores FLVs

	title = flv.dup.gsub!(".flv", ".html")
	vid = flv.dup
	vid.slice!(0..6)
	body = embed.gsub("sample.flv", vid) 
	htmlOutput = File.open(title, "w")
		htmlOutput.write(body)
	htmlOutput.close
	linkList = File.open("#{location}List of Links.txt", "a")
		linkList.write(base + vid.gsub(".flv", ".html") + "\n")
	linkList.close
	puts "Files created successfully." # Kind of unecessary as this will print as long as the directory is valid even if no files are created, I think.
end

###### The actual script ######

folder = is_valid_dir()						# Creates a new instance of the Cleaner class and calls the is_valid_dir method.
files = folder.clone + "*.flv"				# Wildcard query for all .flv's in the folder entered by the user.
flvs = Dir.glob("#{files}") 				# Creates an array of all .flvs files in the directory.
flvs.each { |flv| output(flv, folder) }		# Send each flv file through the my output method.