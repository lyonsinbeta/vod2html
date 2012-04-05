vod2html
=======

This script takes directory input (a directory containing flash video files) and 
creates like-named HTML files with embed HTML for use on a flash server. It 
also outputs a .txt file with URLs to all the HTML files.

## Use

1. Paste your default sample embed code into the **$EMBED_HTML** global, your base URL into the
**$BASE_URL** global, and the sample.flv into the **$SAMPLE_FLV** global.
2. Run the script and follow the prompts or supply the directory as a command line argument.
3. Profit.

## Switches

This version of vod2html has two new features, utilized via command line switches. 

1. -r, --recursive           Recursively scan subdirectories
2. -b, --bothtypes           Scans for .f4v in addition to .flv
3. -h, --help                Displays help

### Example

	ruby vod2html.rb -rb y:/vod/some_folder

This will recursively scan y:/vod/some_folder for all .f4v and .flv files, and create their corresponding HTML file, as well as a sorted link list in the top folder (some_folder, in this case). 

## License

Copyright (c) 2011 David Lyons

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), 
to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, 
and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, 
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER 
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS 
IN THE SOFTWARE.