puts "\n \n \n \n"
puts "#######################################################################"
puts "#                                                                     #"
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
def output(flv, location)
	### HTML embed code
	embed = "<div align='center'> <object width='640' height='377' id='videoPlayer' name='videoPlayer' type='application/x-shockwave-flash' classid='clsid:d27cdb6e-ae6d-11cf-96b8-444553540000' > <param name='movie' value='http://flash.seminolestate.edu/swfs/videoPlayer.swf' /> <param name='quality' value='high' /> <param name='bgcolor' value='#000000' /> <param name='allowfullscreen' value='true' /> <param name='flashvars' value= '&videoWidth=0&videoHeight=0&dsControl=manual&dsSensitivity=100&serverURL=dynamicStream.smil&DS_Status=true&streamType=vod&autoStart=false&videoWidth=0&videoHeight=0&dsControl=manual&dsSensitivity=100&serverURL=http://flash.seminolestate.edu/vod/sample.flv&DS_Status=true&streamType=vod&autoStart=false'/> <embed src='http://flash.seminolestate.edu/swfs/videoPlayer.swf' width='640' height='377' id='videoPlayer' quality='high' bgcolor='#000000' name='videoPlayer' allowfullscreen='true' pluginspage='http://www.adobe.com/go/getflashplayer' flashvars='&videoWidth=0&videoHeight=0&dsControl=manual&dsSensitivity=100&serverURL=dynamicStream.smil&DS_Status=true&streamType=vod&autoStart=false&videoWidth=0&videoHeight=0&dsControl=manual&dsSensitivity=100&serverURL=http://flash.seminolestate.edu/vod/sample.flv&DS_Status=true&streamType=vod&autoStart=false' type='application/x-shockwave-flash'> </embed> </object> </div>"

	### URL base
	base = "http://flash.seminolestate.edu/vod/"
	
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
	puts "Files created successfully."
end

###### The actual program ######

folder = is_valid_dir()						# Creates a new instance of the Cleaner class and calls the is_valid_dir method.
files = folder.clone + "*.flv"				# Wildcard query for all .flv's in the folder entered by the user.
flvs = Dir.glob("#{files}") 				# Creates an array of all .flvs files in the directory.
flvs.each { |flv| output(flv, folder) }		# Send each flv file through the my output method.