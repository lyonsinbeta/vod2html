puts "#######################################################################"
puts "#"
puts "# vod2html v0.85 does not carry any license and is free to be"
puts "# distributed or altered. Enjoy!"
puts "# -- David Lyons"
puts "#"
puts "#######################################################################"


### HTML embed code
embed = "<div align='center'> <object width='640' height='377' id='videoPlayer' name='videoPlayer' type='application/x-shockwave-flash' classid='clsid:d27cdb6e-ae6d-11cf-96b8-444553540000' > <param name='movie' value='http://flash.seminolestate.edu/swfs/videoPlayer.swf' /> <param name='quality' value='high' /> <param name='bgcolor' value='#000000' /> <param name='allowfullscreen' value='true' /> <param name='flashvars' value= '&videoWidth=0&videoHeight=0&dsControl=manual&dsSensitivity=100&serverURL=dynamicStream.smil&DS_Status=true&streamType=vod&autoStart=false&videoWidth=0&videoHeight=0&dsControl=manual&dsSensitivity=100&serverURL=http://flash.seminolestate.edu/vod/sample.flv&DS_Status=true&streamType=vod&autoStart=false'/> <embed src='http://flash.seminolestate.edu/swfs/videoPlayer.swf' width='640' height='377' id='videoPlayer' quality='high' bgcolor='#000000' name='videoPlayer' allowfullscreen='true' pluginspage='http://www.adobe.com/go/getflashplayer' flashvars='&videoWidth=0&videoHeight=0&dsControl=manual&dsSensitivity=100&serverURL=dynamicStream.smil&DS_Status=true&streamType=vod&autoStart=false&videoWidth=0&videoHeight=0&dsControl=manual&dsSensitivity=100&serverURL=http://flash.seminolestate.edu/vod/sample.flv&DS_Status=true&streamType=vod&autoStart=false' type='application/x-shockwave-flash'> </embed> </object> </div>"


### URL base
base = "http://flash.seminolestate.edu/vod/"


### Get location of .flvs from user and transform it into a URL friendly format
puts "\n \n \n \n"
puts "Enter the full directory path of the flv files."

folder = gets.chomp							# Gets folder location from user. #chomp method removes /n from end of #gets input.
folder.gsub!('\\', '/') 					# Sanitized slashes of folder location.
if folder[-1..-1] == '/'
	# Do nothing if it already 
	# ends with a forward slash
else
	folder += '/'
end

files = folder.dup + "*.flv"				# Wildcard query for all .flv's in the folder entered by the user
url = folder.dup							# For some reason using the #dup and #slice method at the same time make #slice behave oddly. Requires research.
url.slice!(0..6)							# Removes drive information from the folder so it can be used in as a URL


### Creates an array of all .flvs files in the current directory
flvs = Dir.glob("#{files}")


### For each .flv in the directory the script will create an html document named
### exactly like the flv file, edit the default embed code, and write it to the file.
flvs.each { |x|
	title = x.dup.gsub!(".flv", ".html")
	vid = x.dup
	vid.slice!(0..6)
	body = embed.gsub("sample.flv", vid) 
	htmlOutput = File.open(title, "w")
		htmlOutput.write(body)
	htmlOutput.close
	linkList = File.open("#{folder}List of Links.txt", "a")
		linkList.write(base + vid.gsub(".flv", ".html") + "\n")
	linkList.close
	}